import 'package:flutter/material.dart';
import 'package:grocery_app/constants/app_colors.dart';
import 'package:grocery_app/services/navigation_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../locator.dart';

class CallToActionMobile extends StatelessWidget {
  final String title;
  final String navTo;
  final Icon icon;
  const CallToActionMobile({this.title, this.navTo, this.icon});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double titleSize =
            sizingInformation.deviceScreenType == DeviceScreenType.Mobile
                ? 50
                : 80;

        double descriptionSize =
            sizingInformation.deviceScreenType == DeviceScreenType.Mobile
                ? 16
                : 21;
        return Container(
          height: 60,
          alignment: Alignment.center,
          child: FlatButton(
            onPressed: () => locator<NavigationService>().navigateTo(navTo),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: icon,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('$title',
                    style: TextStyle(
                        color: Colors.green, fontSize: descriptionSize)),
              ],
            ),
            textColor: Colors.green,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.green, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50)),
          ),
        );
      },
    );
  }
}
