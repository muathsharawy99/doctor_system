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
  Details? data;
  int currentIndex = 0;
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbWVkaWNhbGFwcC5lcmFhc29mdC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2OTI2ODc2MzcsImV4cCI6MTY5MjY5MTIzNywibmJmIjoxNjkyNjg3NjM3LCJqdGkiOiJ6bXVxdjlCbVJramR1dDVEIiwic3ViIjoxNDgsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.5KJ5DDAH6_aSm5JMr8mJBH8u7MrLADi1kcC4T23MH8I";

  var nameController = TextEditingController();
  var dOBController = TextEditingController();
  var diagnosisController = TextEditingController();
  var addressController = TextEditingController();
  var visitTimeController = TextEditingController();

  static PatientCubit get(context) => BlocProvider.of<PatientCubit>(context);

  void getAllPatient() async {
    emit(GetAllPatientLoadingState());
    await DioHelper.get(
      token: token,
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

  Future<void> addNewPatient() async {
    emit(AddNewPatientLoadingState());
    await DioHelper.post(
      data: {
        "name": nameController.text,
        "date_of_birth": dOBController.text,
        "diagnosis": diagnosisController.text,
        "address": addressController.text,
        "visit_time": visitTimeController.text,
      },
      token: token,
      // token: SharedPreference.get(SharedKeys.token),
      endPoint: EndPoints.doctorAddPatient,
    ).then((value) {
      if (value.data['code'] == 200 || value.data['code'] == 201) {
        print("Added");
        showToast(msg: value.data['message'], isError: false);
        emit(AddNewPatientSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      print("No");
      showToast(msg: onError.toString(), isError: true);
      emit(AddNewPatientErrorState());
    });
  }

  void updatePatient() async {
    emit(UpdatePatientLoadingState());
    await DioHelper.post(
      queryParameters: {
        "_method": "put",
      },
      data: {
        "name": nameController.text,
        "date_of_birth": dOBController.text,
        "diagnosis": diagnosisController.text,
        "address": addressController.text,
        "visit_time": visitTimeController.text,
      },
      token: token,
      // token: SharedPreference.get(SharedKeys.token),
      endPoint:
          "${EndPoints.doctorUpdatePatient}/${patientModel?.data?.data?[currentIndex].id}",
    ).then((value) {
      if (value.data['code'] == 200 || value.data['code'] == 201) {
        print("Updated");
        showToast(msg: value.data['message'], isError: false);
        emit(UpdatePatientSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      print("Not Updated");
      showToast(msg: onError.toString(), isError: true);
      emit(UpdatePatientErrorState());
    });
  }

  void deletePatient() async {
    emit(DeletePatientLoadingState());
    await DioHelper.delete(
      token: token,
      // token: SharedPreference.get(SharedKeys.token),
      endPoint:
          "${EndPoints.doctorDeletePatient}/${patientModel?.data?.data?[currentIndex].id}",
    ).then((value) {
      if (value.data['code'] == 200 || value.data['code'] == 201) {
        print("Deleted");
        showToast(msg: value.data['message'], isError: false);
        emit(DeletePatientSuccessState());
      } else {
        print(value.data['code']);
        showToast(msg: value.data['message'].toString(), isError: true);
      }
    }).catchError((onError) {
      print(onError.toString());
      print("Not Deleted");
      showToast(msg: onError.toString(), isError: true);
      emit(DeletePatientErrorState());
    });
  }

  void changeCurrentIndex(index) {
    currentIndex = index;
    emit(ChangeCurrentIndex());
  }

  void initController() {
    nameController.text =
        patientModel?.data?.data?[currentIndex].name ?? "No Name";
    dOBController.text =
        patientModel?.data?.data?[currentIndex].dateOfBirth ?? "No dateOfBirth";
    diagnosisController.text =
        patientModel?.data?.data?[currentIndex].diagnosis ?? "No diagnosis";
    addressController.text =
        patientModel?.data?.data?[currentIndex].address ?? "No address";
    visitTimeController.text =
        patientModel?.data?.data?[currentIndex].visitTime ?? "No visitTime";
  }

  void clearController() {
    nameController.clear();
    dOBController.clear();
    diagnosisController.clear();
    addressController.clear();
    visitTimeController.clear();
  }







}
