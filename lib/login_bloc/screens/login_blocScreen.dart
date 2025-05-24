import 'package:flutter/material.dart';
import 'package:learning/login_bloc/blocs/bloc.dart';
import 'package:learning/login_bloc/blocs/provider.dart';
// import '../../login_form/models/form_model.dart';

class LoginBlocScreen extends StatelessWidget {
  // final _formData = LoginFormData();

  @override
  Widget build(context) {
    final bloc = Provider.of(context);
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          constraints: BoxConstraints(maxWidth: 400),
          // Optional: limit max width
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // Make children stretch horizontally
            children: [
              emailField(bloc),
              SizedBox(height: 16), // Add consistent spacing
              passwordField(bloc),
              SizedBox(height: 25),
              submitButton(bloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email blocss',
            hintText: 'Your Email',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget passwordField(Bloc bloc) {
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

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.hasData ? bloc.submit : null,
          child: Text('Submit'),
        );
      },
    );
  }
}
