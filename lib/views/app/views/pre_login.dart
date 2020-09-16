import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grocery_app/routing/route_names.dart';

import 'subViews/login/components/anonymous_button.dart';

class InterfereView extends StatelessWidget {
  const InterfereView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://weedmaps.com/learn/wp-content/uploads/2019/05/180813_Plant_61-1.jpg'),
                  fit: BoxFit.fitHeight)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 5),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New to FramerLink ?',
                    style: TextStyle(
                        fontFamily: 'Montserrat', color: Colors.white70),
                  ),
                  SizedBox(height: 10.0),
                  AnonymouseButton(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Or',
                    style: TextStyle(
                        fontFamily: 'Montserrat', color: Colors.white70),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 40.0,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, LoginRoute,
                          arguments: {
                            'from': PreLoginRoute,
                            'next': LoginRoute
                          }),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent.withOpacity(0.3),
                        color: Colors.green,
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
