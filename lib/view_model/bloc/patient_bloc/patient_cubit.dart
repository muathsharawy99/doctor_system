import 'package:doctor/model/doctor_model.dart';
import 'package:doctor/model/patient_model.dart';
import 'package:doctor/view/components/my_customization/custom_toast.dart';
import 'package:doctor/view/screens/auth/register_screen.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_state.dart';
import 'package:doctor/view_model/local/shared_preferences/shared_key.dart';
import 'package:doctor/view_model/local/shared_preferences/shared_preferences.dart';
import 'package:doctor/view_model/navigation/navigation.dart';
import 'package:doctor/view_model/network/dio_helper/dio_helper.dart';
import 'package:doctor/view_model/network/dio_helper/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit() : super(InitState());

  PatientModel? patientModel;
  DoctorModel? doctorModel;
  Details? data;
  int currentIndex = 0;

  var nameController = TextEditingController();
  var dOBController = TextEditingController();
  var diagnosisController = TextEditingController();
  var addressController = TextEditingController();
  var visitTimeController = TextEditingController();

  var passwordController = TextEditingController();
  var typeController = TextEditingController();
  var titleController = TextEditingController();

  static PatientCubit get(context) => BlocProvider.of<PatientCubit>(context);

  void changeCurrentIndex(index) {
    currentIndex = index;
    emit(ChangeCurrentIndex());
  }

  void initPatientController() {
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

  void initDoctorController() {
    nameController.text =
        SharedPreference.get(SharedKeys.userName) ?? "No Name";
    passwordController.text =
        SharedPreference.get(SharedKeys.userPassword) ?? "No Password";
    typeController.text =
        SharedPreference.get(SharedKeys.userType) ?? "No Type";
    titleController.text =
        SharedPreference.get(SharedKeys.userTitle) ?? "No Title";
    addressController.text =
        SharedPreference.get(SharedKeys.userAddress) ?? "No address";
  }

  void clearController() {
    nameController.clear();
    dOBController.clear();
    diagnosisController.clear();
    addressController.clear();
    visitTimeController.clear();
    passwordController.clear();
    typeController.clear();
    titleController.clear();
  }

  void getAllPatient() async {
    emit(GetAllPatientLoadingState());
    await DioHelper.get(
      token: SharedPreference.get(
        SharedKeys.userToken,
      ),
      endPoint: EndPoints.doctorGetAllPatients,
    ).then((value) {
      if (value.data['code'] == 200 || value.data['code'] == 201) {
        patientModel = PatientModel.fromJson(value.data);
        emit(GetAllPatientSuccessState());
      }
    }).catchError((onError) {
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
      token: SharedPreference.get(
        SharedKeys.userToken,
      ),
      endPoint: EndPoints.doctorAddPatient,
    ).then((value) {
      if (value.data['code'] == 200 || value.data['code'] == 201) {
        showToast(msg: value.data['message'], isError: false);
        emit(AddNewPatientSuccessState());
      }
    }).catchError((onError) {
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
      token: SharedPreference.get(
        SharedKeys.userToken,
      ),
      endPoint:
          "${EndPoints.doctorUpdatePatient}/${patientModel?.data?.data?[currentIndex].id}",
    ).then((value) {
      if (value.data['code'] == 200 || value.data['code'] == 201) {
        showToast(msg: value.data['message'], isError: false);
        emit(UpdatePatientSuccessState());
      }
    }).catchError((onError) {
      showToast(msg: onError.toString(), isError: true);
      emit(UpdatePatientErrorState());
    });
  }

  void deletePatient() async {
    emit(DeletePatientLoadingState());
    await DioHelper.delete(
      token: SharedPreference.get(
        SharedKeys.userToken,
      ),
      endPoint:
          "${EndPoints.doctorDeletePatient}/${patientModel?.data?.data?[currentIndex].id}",
    ).then((value) {
      if (value.data['code'] == 200 || value.data['code'] == 201) {
        showToast(msg: value.data['message'], isError: false);
        emit(DeletePatientSuccessState());
      } else {
        showToast(msg: value.data['message'].toString(), isError: true);
      }
    }).catchError((onError) {
      showToast(msg: onError.toString(), isError: true);
      emit(DeletePatientErrorState());
    });
  }

  void updateDoctor(context) async {
    emit(UpdateDoctorLoadingState());
    await DioHelper.post(
      queryParameters: {
        "_method": "put",
      },
      data: {
        "name": nameController.text,
        "password": passwordController.text,
        "type": typeController.text,
        "title": titleController.text,
        "address": addressController.text,
      },
      token: SharedPreference.get(SharedKeys.userToken),
      endPoint: "${EndPoints.doctorUpdateData}/${doctorModel?.data?.id}",
    ).then((value) {
      if (value.data['code'] == 200 || value.data['code'] == 201) {
        showToast(msg: value.data['message'], isError: false);
        SharedPreference.clear();
        Navigation.goPushAndReplacement(
          context,
          const RegisterScreen(),
        );
        emit(UpdateDoctorSuccessState());
      }
    }).catchError((onError) {
      showToast(msg: onError.toString(), isError: true);
      emit(UpdateDoctorErrorState());
    });
  }

  void logout(context) async {
    emit(LogoutLoadingState());
    await DioHelper.post(
      endPoint: EndPoints.logout,
    ).then((value) {
      if (value.data["code"] == 200) {
        showToast(msg: value.data['message'], isError: false);
        SharedPreference.clear();
        Navigation.goPushAndReplacement(
          context,
          const RegisterScreen(),
        );
        emit(LogoutSuccessState());
      } else {
        showToast(msg: value.data['message'], isError: true);
        emit(LogoutErrorState());
      }
    });
  }
}
