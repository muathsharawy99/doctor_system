import 'package:doctor/model/patient_model.dart';
import 'package:doctor/view/components/my_customization/custom_toast.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_state.dart';
import 'package:doctor/view_model/local/shared_preferences/shared_key.dart';
import 'package:doctor/view_model/local/shared_preferences/shared_preferences.dart';
import 'package:doctor/view_model/network/dio_helper/dio_helper.dart';
import 'package:doctor/view_model/network/dio_helper/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit() : super(InitState());
  PatientModel? patientModel;
  Data? data;

  var nameController = TextEditingController();
  var dOBController = TextEditingController();
  var diagnosisController = TextEditingController();
  var addressController = TextEditingController();
  var visitTimeController = TextEditingController();

  static PatientCubit get(context) => BlocProvider.of<PatientCubit>(context);

  void getAllPatient() async {
    emit(GetAllPatientLoadingState());
    await DioHelper.get(
      token:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbWVkaWNhbGFwcC5lcmFhc29mdC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2OTI2NzE5MDMsImV4cCI6MTY5MjY3NTUwMywibmJmIjoxNjkyNjcxOTAzLCJqdGkiOiJiV2JHS0tnQnNURHg1Y2loIiwic3ViIjoxNDgsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.tULUlRh4Bb8Ds9QhS8kUKqPosBL7PTgTN4rgXurUx0U",
      // token: SharedPreference.get(SharedKeys.token),
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

  int currentIndex = 0;

  void changeCurrentIndex(index) {
    currentIndex = index;
    emit(ChangeCurrentIndex());
  }

  void initController() {
    nameController.text = data?.data?[currentIndex].name ?? "No Name";
    print(nameController.text);
    dOBController.text =
        data?.data?[currentIndex].dateOfBirth ?? "No dateOfBirth";
    diagnosisController.text =
        data?.data?[currentIndex].diagnosis ?? "No diagnosis";
    addressController.text = data?.data?[currentIndex].address ?? "No address";
    visitTimeController.text =
        data?.data?[currentIndex].visitTime ?? "No visitTime";
  }
}
