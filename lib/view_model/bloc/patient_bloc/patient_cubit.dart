import 'package:doctor/model/patient_model.dart';
import 'package:doctor/view/components/my_customization/custom_toast.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_state.dart';
import 'package:doctor/view_model/network/dio_helper/dio_helper.dart';
import 'package:doctor/view_model/network/dio_helper/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit() : super(InitState());
  PatientModel? patientModel;

  static PatientCubit get(context) => BlocProvider.of<PatientCubit>(context);

  void getAllPatient() async {
    emit(GetAllPatientLoadingState());
    await DioHelper.get(
      token:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbWVkaWNhbGFwcC5lcmFhc29mdC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2OTI1Njc5MzQsImV4cCI6MTY5MjU3MTUzNCwibmJmIjoxNjkyNTY3OTM0LCJqdGkiOiI4UXRBWkpJYm9veXN3YW5BIiwic3ViIjoxNDgsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.Hs8VmDVg5nJxyZiidnSv1klYDJbgO-blDfHfi17W7X4",
      endPoint: EndPoints.doctorGetAllPatients,
    ).then((value) {
      if (value.data['code'] == 200 || value.data['code'] == 201) {
        print("HI");
        patientModel = PatientModel.fromJson(value.data);
        emit(GetAllPatientSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      print("WEL");
      showToast(msg: onError.toString(), isError: true);
      emit(GetAllPatientErrorState());
    });
  }
}
