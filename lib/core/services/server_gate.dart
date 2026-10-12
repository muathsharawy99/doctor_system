import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import '../extensions/unified_extensions.dart';
import '../utils/logger.dart';

/// Single Dio instance; every call resolves to a [CustomResponse].
/// The API reports success with `code` 200 / 201 in the body.
class ServerGate {
  static bool logEnabled = kDebugMode;

  Map<String, dynamic> get constHeader => {
    if (UserModel.i.isAuth) "Authorization": "Bearer ${UserModel.i.token}",
    "Accept": "application/json",
    "Accept-Language": LocaleKeys.lang.tr(),
  };

  final Dio _dio = Dio();

  ServerGate._() {
    _dio.interceptors.add(CustomApiInterceptor());
    _dio.options = _dio.options.copyWith(
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    );
  }

  static final ServerGate i = ServerGate._();

  static void _clean(Map<String, dynamic>? map) {
    map?.removeWhere((key, value) => value == null || '$value'.trim().isEmpty);
  }

  String _resolveUrl(String url) =>
      url.startsWith('http') ? url : '${ApiConstants.baseUrl}/$url';

  Future<CustomResponse<T>> getFromServer<T>({
    required String url,
    Map<String, dynamic>? params,
  }) => _request<T>(
    () => _dio.get(
      _resolveUrl(url),
      queryParameters: params,
      options: Options(headers: constHeader),
    ),
    params: params,
  );

  /// POST `body` as JSON (`params` go in the query, e.g. `_method=put`).
  Future<CustomResponse<T>> sendToServer<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) {
    _clean(body);
    return _request<T>(
      () => _dio.post(
        _resolveUrl(url),
        data: body ?? {},
        queryParameters: params,
        options: Options(headers: constHeader),
      ),
      params: params,
    );
  }

  Future<CustomResponse<T>> deleteFromServer<T>({required String url}) =>
      _request<T>(
        () => _dio.delete(
          _resolveUrl(url),
          options: Options(headers: constHeader),
        ),
      );

  Future<CustomResponse<T>> _request<T>(
    Future<Response> Function() call, {
    Map<String, dynamic>? params,
  }) async {
    _clean(params);
    try {
      final res = await call();
      final data = res.data;
      final code = data is Map ? data['code'] : null;
      final ok = data is Map && AppConstants.successCodes.contains(code);
      return CustomResponse<T>(
        success: ok,
        statusCode: code is int ? code : (res.statusCode ?? 200),
        errType: ok ? ErrorType.none : ErrorType.backEndValidation,
        msg: _safeMessage(
          data,
          fallback: ok
              ? ''
              : LocaleKeys.something_went_wrong_please_try_again.tr(),
        ),
        data: data as T?,
      );
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      return CustomResponse<T>(
        success: false,
        statusCode: 422,
        errType: ErrorType.unknown,
        msg: kDebugMode
            ? '$e'
            : LocaleKeys.something_went_wrong_please_try_again.tr(),
      );
    }
  }

  Future<CustomResponse<T>> _handleError<T>(DioException err) async {
    if (err.type == DioExceptionType.badResponse) {
      if (err.response?.statusCode == 401) {
        await UserModel.i.clear();
        pushAndRemoveUntil(AppRoutes.init.initial);
        return CustomResponse<T>(
          success: false,
          statusCode: 401,
          errType: ErrorType.unAuth,
          msg: _safeMessage(err.response?.data),
        );
      }
      return CustomResponse<T>(
        success: false,
        statusCode: err.response?.statusCode ?? 500,
        errType: ErrorType.backEndValidation,
        msg: _safeMessage(
          err.response?.data,
          fallback: LocaleKeys.something_went_wrong_please_try_again.tr(),
        ),
      );
    }
    if (err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return CustomResponse<T>(
        success: false,
        errType: ErrorType.network,
        msg: LocaleKeys.poor_connection_check_the_quality_of_the_internet.tr(),
      );
    }
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.connectionError ||
        err.response == null) {
      return CustomResponse<T>(
        success: false,
        errType: ErrorType.network,
        msg: LocaleKeys.please_check_your_internet_connection.tr(),
      );
    }
    return CustomResponse<T>(
      success: false,
      errType: ErrorType.unknown,
      msg: LocaleKeys.something_went_wrong_please_try_again.tr(),
    );
  }

  /// First `errors` entry, else `message`, else [fallback].
  static String _safeMessage(dynamic value, {String fallback = ''}) {
    if (value is Map) {
      final errors = _firstError(value['errors']);
      if (errors.isNotEmpty) return errors;
      final message = value['message']?.toString() ?? '';
      if (message.trim().isNotEmpty) return message;
    }
    return fallback;
  }

  static String _firstError(dynamic errors) {
    if (errors == null) return '';
    if (errors is List) return errors.isEmpty ? '' : _firstError(errors.first);
    if (errors is Map) {
      for (final entry in errors.entries) {
        final message = _firstError(entry.value);
        if (message.trim().isNotEmpty) return message;
      }
      return '';
    }
    return errors.toString();
  }
}

class CustomApiInterceptor extends Interceptor {
  final _log = LoggerDebug(
    headColor: LogColors.red,
    constTitle: 'Server Gate Logger',
    enabled: ServerGate.logEnabled,
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log.red(
      '------ Current Error Response (status code ${err.response?.statusCode}) -----',
    );
    _log.red(jsonEncode(err.response?.data));
    _log.white(_curl(err.requestOptions));
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log.green(
      '------ Current Response (status code ${response.statusCode}) ------',
    );
    _log.green(jsonEncode(response.data));
    _log.white(_curl(response.requestOptions));
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log.yellow('------ Current Request Path -----');
    _log.yellow(
      '${options.path} ${LogColors.red}API METHOD : (${options.method})${LogColors.reset}',
    );
    if (options.data != null) {
      _log.blue('------ Current Request Body Data -----');
      _log.blue(jsonEncode(options.data));
    }
    _log.blue('------ Current Request Parameters Data -----');
    _log.blue(jsonEncode(options.queryParameters));
    super.onRequest(options, handler);
  }

  String _curl(RequestOptions options) {
    final curl = StringBuffer("curl -X ${options.method} '${options.uri}'");
    options.headers.forEach((key, value) => curl.write(" -H '$key: $value'"));
    final data = options.data;
    if (data is Map) curl.write(" --data '${jsonEncode(data)}'");
    return curl.toString();
  }
}

class CustomResponse<T> {
  bool success;
  ErrorType errType;
  String msg;
  int statusCode;
  T? data;

  CustomResponse({
    this.success = false,
    this.errType = ErrorType.none,
    this.msg = "",
    this.statusCode = 0,
    this.data,
  });
}
