import 'package:doctor/core/extensions/cubit_enums.dart';
import 'package:equatable/equatable.dart';

class PatientDetailsState extends Equatable {
  const PatientDetailsState({
    this.saveStatus = RequestState.initial,
    this.deleteStatus = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  final RequestState saveStatus;
  final RequestState deleteStatus;
  final String msg;
  final ErrorType errorType;

  bool get isBusy => saveStatus.isLoading || deleteStatus.isLoading;

  PatientDetailsState copyWith({
    RequestState? saveStatus,
    RequestState? deleteStatus,
    String? msg,
    ErrorType? errorType,
  }) => PatientDetailsState(
    saveStatus: saveStatus ?? this.saveStatus,
    deleteStatus: deleteStatus ?? this.deleteStatus,
    msg: msg ?? this.msg,
    errorType: errorType ?? this.errorType,
  );

  @override
  List<Object?> get props => [saveStatus, deleteStatus, msg, errorType];
}
