mixin ValidationMixin {
  String? email;
  String? password;

  String? validateEmail(String? value) {
    if (value?.contains('@') != true) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.length < 4) {
      return 'Please enter a valid password';
    }
    return null;
  }

  void onEmailSaved(String? value) {
    email = value;
  }

  void onPasswordSaved(String? value) {
    password = value;
  }
}
