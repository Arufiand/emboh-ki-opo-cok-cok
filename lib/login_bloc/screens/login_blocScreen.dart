import 'package:flutter/material.dart';
import 'package:learning/login_bloc/blocs/bloc.dart';
import '../../login_form/models/form_model.dart';

class LoginBlocScreen extends StatelessWidget {
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
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email bloc',
            hintText: 'Your Email',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Your Password',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget submitButton() {
    return ElevatedButton(onPressed: () => {}, child: Text('Submit'));
  }
}
