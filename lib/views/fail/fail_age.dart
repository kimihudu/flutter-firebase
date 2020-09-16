import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FailAgeView extends StatelessWidget {
  const FailAgeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      var textAlignment =
          sizingInformation.deviceScreenType == DeviceScreenType.Desktop
              ? TextAlign.center
              : TextAlign.center;
      double titleSize =
          sizingInformation.deviceScreenType == DeviceScreenType.Mobile
              ? 50
              : 80;

      double descriptionSize =
          sizingInformation.deviceScreenType == DeviceScreenType.Mobile
              ? 16
              : 19;
      return Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'logo.png',
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'We\'re sorry!',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                height: 1.2,
                fontSize: titleSize,
                color: Colors.green[300],
              ),
              textAlign: textAlignment,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'You\'re not old enough to visit Weedmaps.\nPlease come back when you\'re of age.',
              style: TextStyle(
                fontSize: descriptionSize,
                height: 1.7,
              ),
              textAlign: textAlignment,
            )
          ],
        )),
      );
    });
  }
}
