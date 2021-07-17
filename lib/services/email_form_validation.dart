class EmailFormValidator {
  bool isEmailValid(String email) {
    if (email.isNotEmpty) {
      //add here more
      return true;
    }
    return false;
  }

  bool isPasswordValid(String password) {
    if (password.isNotEmpty) {
      return true;
    }
    return false;
  }
}
