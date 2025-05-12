// lib/login_form/models/form_models.dart
class LoginFormData {
  String? email;
  String? password;

  LoginFormData({this.email, this.password});

  // You could add methods like
  bool isValid() {
    return email != null && password != null;
  }

  // Optional: Add toString for debugging
  @override
  String toString() {
    return 'LoginFormData(email: $email, password: $password)';
  }

  // Optional: Add clear method
  void clear() {
    email = null;
    password = null;
  }
}

class SignUpFormData {
  String? email;
  String? password;
  String? confirmPassword;
  String? username;

  SignUpFormData({
    this.email,
    this.password,
    this.confirmPassword,
    this.username,
  });
}

class ForgotPasswordFormData {
  String? email;

  ForgotPasswordFormData({this.email});
}
