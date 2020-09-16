import 'package:flutter/material.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:grocery_app/widgets/call_to_action/call_to_action.dart';
import 'package:grocery_app/widgets/course_details/course_details.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeContentMobile extends StatelessWidget {
  const HomeContentMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
        ))
      ],
    );
  }
}
