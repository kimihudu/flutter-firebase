import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        var textAlignment =
            sizingInformation.deviceScreenType == DeviceScreenType.Desktop
                ? TextAlign.center
                : TextAlign.center;
        double titleSize =
            sizingInformation.deviceScreenType == DeviceScreenType.Mobile
                ? 40
                : 50;

        double descriptionSize =
            sizingInformation.deviceScreenType == DeviceScreenType.Mobile
                ? 14
                : 16;

        return Container(
          width: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   'logo.png',
              //   alignment: Alignment.center,
              // ),
              Text(
                'ARE YOU 19 OR OLDER?',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  height: 1.2,
                  fontSize: titleSize,
                  fontFamily: 'Strait',
                  color: Colors.green[300],
                ),
                textAlign: textAlignment,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'If you\'re located in Alberta, Manitoba, or Quebec, you must be 18 or older.  ',
                style: TextStyle(
                  fontSize: descriptionSize,
                  height: 1.7,
                ),
                textAlign: textAlignment,
              )
            ],
          ),
        );
      },
    );
  }
}
