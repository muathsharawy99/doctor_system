abstract class PatientState {}

class InitState extends PatientState {}


class GetAllPatientLoadingState extends PatientState{}
class GetAllPatientSuccessState extends PatientState{}
class GetAllPatientErrorState extends PatientState{}




class AddNewPatientLoadingState extends PatientState{}
class AddNewPatientSuccessState extends PatientState{}
class AddNewPatientErrorState extends PatientState{}




class UpdatePatientLoadingState extends PatientState{}
class UpdatePatientSuccessState extends PatientState{}
class UpdatePatientErrorState extends PatientState{}





class DeletePatientLoadingState extends PatientState{}
class DeletePatientSuccessState extends PatientState{}
class DeletePatientErrorState extends PatientState{}



class ChangeCurrentIndex extends PatientState{}