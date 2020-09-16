import 'package:flutter/material.dart';
import 'package:grocery_app/routing/route_names.dart';

class AnonymouseButton extends StatelessWidget {
  const AnonymouseButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, MainAppViewRoute,
          arguments: {'index': 0, 'data': null}),
      child: Container(
        height: 40.0,
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Colors.transparent,
          color: Colors.green,
          elevation: 7.0,
          child: Center(
            child: Text(
              'View Shop',
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
