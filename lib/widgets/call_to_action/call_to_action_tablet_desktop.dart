import 'package:flutter/material.dart';
import 'package:grocery_app/services/navigation_service.dart';
import '../../locator.dart';

class CallToActionTabletDesktop extends StatelessWidget {
  final String title;
  final String navTo;
  const CallToActionTabletDesktop({this.title, this.navTo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: FlatButton(
        onPressed: () => locator<NavigationService>().navigateTo(navTo),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.launch),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.green, fontSize: 32),
            ),
          ],
        ),
        textColor: Colors.green,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.green, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
