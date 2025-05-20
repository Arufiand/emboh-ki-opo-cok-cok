import 'package:flutter/material.dart';
import 'package:learning/login_form/mixins/validation_mixin.dart';
import '../../login_form/models/form_model.dart';

class LoginBlocScreen extends StatelessWidget with ValidationMixin {
  final _formData = LoginFormData();

  @override
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          emailField(),
          passwordField(),
          Container(margin: EdgeInsets.only(top: 25.0)),
          submitButton(),
        ],
      ),
    );
  }

  Widget emailField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'email bloc',
        hintText: 'Your Email',
      ),
    );
  }

  Widget passwordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Your Password',
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(onPressed: () => {}, child: Text('Submit'));
  }

  void _onEmailSaved(String? value) {
    _formData.email = value;
  }

  void _onPasswordSaved(String? value) {
    _formData.password = value;
  }
}
