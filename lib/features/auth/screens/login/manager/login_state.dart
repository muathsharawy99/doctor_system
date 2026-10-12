import 'package:doctor/core/extensions/cubit_enums.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.isDoctor = true,
    this.isAdmin = false,
  });

  final RequestState status;
  final String msg;
  final ErrorType errorType;
  final bool isDoctor, isAdmin;

  bool get hasRole => isDoctor || isAdmin;

  LoginState copyWith({
    RequestState? status,
    String? msg,
    ErrorType? errorType,
    bool? isDoctor,
    bool? isAdmin,
  }) => LoginState(
    status: status ?? this.status,
    msg: msg ?? this.msg,
    errorType: errorType ?? this.errorType,
    isDoctor: isDoctor ?? this.isDoctor,
    isAdmin: isAdmin ?? this.isAdmin,
  );

  @override
  List<Object?> get props => [status, msg, errorType, isDoctor, isAdmin];
}
