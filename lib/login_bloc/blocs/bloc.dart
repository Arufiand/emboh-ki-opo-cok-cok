import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:learning/login_bloc/blocs/validators.dart';

class Bloc extends Object with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (emailValue, passwordValue) => true);

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  submit() {
    final emailValid = _email.value;
    final passwordValid = _password.value;

    print('Email value is $emailValid');
    print('Password value is $passwordValid');
  }

  dispose() {
    _email.close();
    _password.close();
  }
}
