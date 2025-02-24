class EndPoint {
  static String baseUrl = "https://scopey.onrender.com/api";
  static String signIn = "/nectar/login";
  static String signUp = "/nectar/signUp";
  static String doctorSignUp = "auth/register/specialist";
  static String signUpSpecialist = "/specialist/register";
  static String getSpecialist = "/specialist/getByCategory";
  static String getAllSpecialist = "/specialist/getSpecialists";

  static String getSpecialistSessions(String id) {
    return "/sessions/specialist/$id";
  }

  static String getBenificSessions(String id) {
    return "/sessions/beneficiary/$id";
  }
}

class ApiKey {
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String message = "message";
  static String error = "error";

  static String id = "_id";
  static String username = "username";
  static String phone = "phone";
  static String confirmPassword = "confirmPassword";
  static String location = "location";
  static String profilePic = "profilePic";

  static String region = "region";
  static String company = "company";
  static String firstName = "firstName";
  static String lastName = "lastName";
  static String age = "age";
  static String availability = "availability";
  static String nationality = "nationality";
  static String work = "work";
  static String workAddress = "workAddress";
  static String homeAddress = "homeAddress";
  static String files = "files";
  static String title = "title";
  static String bio = "bio";
  static String sessionPrice = "sessionPrice";
  static String yearsExperience = "yearsExperience";
  static String sessionDuration = "sessionDuration";
}
