import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:js';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class EmbededGame extends StatefulWidget {
  EmbededGame();

  _EmbededGameState createState() => _EmbededGameState();
}

class _EmbededGameState extends State<EmbededGame> {
  String createdViewId = 'map_element';

  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        createdViewId,
        (int viewId) => html.IFrameElement()
          ..width = '800'
          ..height = '1200'
          ..src ='https://www.peelregion.ca/coronavirus/case-status/'

              //'https://s3-eu-west-1.amazonaws.com/apps.playcanvas.com/R2axJfsc/index.html'
              //'https://play.gamepix.com/tentrix/embed?rgx=1&gpxref=direct' 
              //'https://cdn.htmlgames.com/ForestQueen/index.html'
              //"http://dev.balooboo.surge.sh/popit.html" 
              //'https://www.youtube.com/embed/IyFZznAk69U'
          ..style.border = 'none');

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300], width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        width: 200,
        height: 1200,
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: HtmlElementView(
              viewType: createdViewId,
            )));
  }
}
