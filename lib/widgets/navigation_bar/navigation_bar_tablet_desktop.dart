import 'package:flutter/material.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:grocery_app/views/games/webview_html.dart';

import 'navbar_item.dart';
import 'navbar_logo.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavBarItem('Games', GamesRoute),
              // NavBarItem('Episodes', EpisodesRoute),
              SizedBox(
                width: 60,
              ),
              NavBarItem('About', AboutRoute),
            ],
          )
        ],
      ),
    );
  }
}
