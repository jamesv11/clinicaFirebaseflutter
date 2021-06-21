import 'dart:async';

import 'package:parcialclinicafirebase/src/screens/bloc/validators.dart';

import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passWordController = BehaviorSubject<String>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidate);
  Stream<String> get passWordStream =>
      _passWordController.stream.transform(passwordValidate);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(passWordStream, emailStream, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passWordController.sink.add;

  String get email => _emailController.value;
  String get password => _passWordController.value;

  dispose() {
    _emailController?.close();
    _passWordController?.close();
  }
}
