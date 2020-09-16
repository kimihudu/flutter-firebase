import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/blocs/blocs.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed()),
      child: Container(
        height: 40.0,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black, style: BorderStyle.solid, width: 1.0),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Icon(FontAwesomeIcons.google, color: Colors.red),
              ),
              SizedBox(width: 10.0),
              Center(
                child: Text('Log in with Google',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
