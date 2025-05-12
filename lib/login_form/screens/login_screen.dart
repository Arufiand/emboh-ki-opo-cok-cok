import 'package:flutter/material.dart';
import 'package:learning/login_form/mixins/validation_mixin.dart';
import '../models/form_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final _formData = LoginFormData();

  @override
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(),
            passwordField(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'Email', hintText: 'Your Email'),
      validator: validateEmail,
      onSaved: _onEmailSaved,
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Your Password',
      ),
      validator: validatePassword,
      onSaved: _onPasswordSaved,
    );
  }

  void _handleSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      debugPrint('Email: ${_formData.email}');
      debugPrint('Password: ${_formData.password}');
      // Here you can handle the login logic
    }
  }

  Widget submitButton() {
    return ElevatedButton(onPressed: _handleSubmit, child: Text('Submit'));
  }

  void _onEmailSaved(String? value) {
    _formData.email = value;
  }

  void _onPasswordSaved(String? value) {
    _formData.password = value;
  }
}
