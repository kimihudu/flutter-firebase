import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'main_content_desktop.dart';
import 'main_content_mobile.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AppContentMobile(),
      desktop: AppContentDesktop(),
    );
  }
}
