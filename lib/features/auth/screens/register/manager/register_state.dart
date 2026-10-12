import 'package:doctor/core/extensions/cubit_enums.dart';
import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  final RequestState status;
  final String msg;
  final ErrorType errorType;

  RegisterState copyWith({
    RequestState? status,
    String? msg,
    ErrorType? errorType,
  }) => RegisterState(
    status: status ?? this.status,
    msg: msg ?? this.msg,
    errorType: errorType ?? this.errorType,
  );

  @override
  List<Object?> get props => [status, msg, errorType];
}
