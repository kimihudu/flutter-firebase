import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: InkWell(
        onTap: _onPressed,
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Colors.greenAccent,
          color: Colors.green,
          elevation: 7.0,
          child: Center(
            child: Text(
              'LOGIN',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ),
      ),
    );
  }
}
