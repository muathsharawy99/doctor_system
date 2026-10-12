import 'package:doctor/core/extensions/cubit_enums.dart';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.logoutStatus = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  final RequestState logoutStatus;
  final String msg;
  final ErrorType errorType;

  ProfileState copyWith({
    RequestState? logoutStatus,
    String? msg,
    ErrorType? errorType,
  }) => ProfileState(
    logoutStatus: logoutStatus ?? this.logoutStatus,
    msg: msg ?? this.msg,
    errorType: errorType ?? this.errorType,
  );

  @override
  List<Object?> get props => [logoutStatus, msg, errorType];
}
