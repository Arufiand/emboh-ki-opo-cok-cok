import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

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
      validator: (value) {
        if (!value!.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;

        // you can write if null like this one
        // if (value?.contains('@') == false || value == null) {
        //   return 'Please enter a valid email';
        // }
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Your Password',
      ),
      validator: (value) {
        if (value!.length < 4) {
          return 'Please enter a valid password';
        }
        return null;
      },
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        print(formKey.currentState?.validate());
      },
      child: Text('Submit'),
    );
  }
}
