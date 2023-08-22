abstract class PatientState {}

class InitState extends PatientState {}


class GetAllPatientLoadingState extends PatientState{}
class GetAllPatientSuccessState extends PatientState{}
class GetAllPatientErrorState extends PatientState{}



class ChangeCurrentIndex extends PatientState{}