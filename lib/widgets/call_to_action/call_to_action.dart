import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:grocery_app/widgets/call_to_action/call_to_action_mobile.dart';
import 'package:grocery_app/widgets/call_to_action/call_to_action_tablet_desktop.dart';

class CallToAction extends StatelessWidget {
  final String title;
  final String navTo;
  final Icon icon;
  CallToAction({this.title, this.navTo, this.icon});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CallToActionMobile(
        title: title,
        navTo: navTo,
        icon: icon,
      ),
      tablet: CallToActionTabletDesktop(
        title: title,
        navTo: navTo,
      ),
    );
  }
}
