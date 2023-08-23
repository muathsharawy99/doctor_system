class EndPoints {
  static String baseUrl = "https://medicalapp.eraasoft.com/api/";

  static String register = "auth/register";
  static String login = "auth/login";
  static String logout = "auth/logout";

  static String adminGetAllDoctors = "getalluser";
  static String adminAddDoctor = "adduser";
  static String adminUpdateDoctor = "updateuser";
  static String adminDeleteDoctor = "deleteuser";

  static String adminAddPatient = "patients";
  static String adminUpdatePatient = "patients";
  static String adminGetAllPatients = "patients";
  static String adminDeletePatient = "patients";

  static String doctorAddPatient = "doctorpatients";
  static String doctorUpdateData = "doctorpatients";
  static String doctorGetAllPatients = "doctorpatients";
  static String doctorUpdatePatient = "doctorpatients";
  static String doctorDeletePatient = "patients";
}
