import 'package:flutter/material.dart';
import 'package:grocery_app/repo/user_repo.dart';
import 'package:grocery_app/views/app/views/subViews/register/register_view.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'New to FramerLink ?',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        SizedBox(width: 5.0),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return RegisterScreen(userRepository: _userRepository);
              }),
            );
          },
          child: Text(
            'Register',
            style: TextStyle(
                color: Colors.green,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
