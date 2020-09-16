import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:grocery_app/repo/user_repo.dart';

import 'login_form.dart';

class LoginViewExt extends StatelessWidget {
  final UserRepository _userRepository;

  LoginViewExt({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Login')),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }
}
