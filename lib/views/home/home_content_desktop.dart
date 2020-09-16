import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:grocery_app/views/games/webview_html.dart';
import 'package:grocery_app/widgets/call_to_action/call_to_action.dart';
import 'package:grocery_app/widgets/course_details/course_details.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeContentDesktop extends StatelessWidget {
  const HomeContentDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
          SizedBox(
          height: 100,
        ),
        CourseDetails(),
          SizedBox(
          height: 100,
        ),
       Row(
          children: [
            Expanded(
                child: CallToAction(
              title: 'No, I am not.',
              navTo: FailAgeRoute,
              icon: null,
            )),
            Expanded(
                child: CallToAction(
              title: 'Yes, I am.',
              navTo: AppRoute,
            ))
          ],
        ),
         SizedBox(
          height: 100,
        ),
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.copyright),
            Text('2020 - VincentPOS'),
          ],
        )),
      ],
    );
  }
}
