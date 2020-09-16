import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  const RegisterPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;
  final Uint8List img8;

  const RegisterSubmitted({
    @required this.email,
    @required this.password,
    @required this.img8,
  });

  @override
  List<Object> get props => [email, password, img8];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password, img: ${img8.length} }';
  }
}
