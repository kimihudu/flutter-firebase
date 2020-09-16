import 'package:flutter/material.dart';
import 'package:grocery_app/views/app/views/welcome.dart';
import 'package:grocery_app/widgets/course_details/course_details.dart';

class AppContentDesktop extends StatelessWidget {
  const AppContentDesktop({Key key}) : super(key: key);
  // static final AppRepo AppRepo =
  //     AppRepo(AppRequest: AppRequest());

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Row(
        children: <Widget>[
          CourseDetails(),
          Expanded(
            child: Container(
              color: Colors.yellow[300],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'TheWeedBoy',
                theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.amber,
                ),
                home: WelcomeView(),
                routes: {
                  '/home': (context) => WelcomeView(),
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
