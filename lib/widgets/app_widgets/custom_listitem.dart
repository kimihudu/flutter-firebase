import 'package:flutter/material.dart';
import 'package:grocery_app/constants/setting.dart';

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.statusSecPos,
    this.fontSize,
    this.statusSec,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String statusSecPos;
  final double fontSize;
  final List<Widget> statusSec;
  double _defaultSize;

  @override
  Widget build(BuildContext context) {
    _defaultSize = AppSetting.settingBtnNoSC(context)['fontSize'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Visibility(
          visible: title == null ? false : true,
          child: _headerItem(),
        )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: author == null ? false : true,
                child: Text(
                  '$author',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
              _statusItem()
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusItem() {
    return Expanded(
      child: Visibility(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: statusSec,
        ),
      ),
    );
  }

  Widget _headerItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$title',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize == 0 ? _defaultSize : fontSize,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Text(
          '$subtitle',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize:
                  fontSize, //== 0 ? _defaultSize * 9 / 10 : fontSize * 9 / 10,
              color: Colors.black54,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CustomListItem extends StatelessWidget {
  CustomListItem(
      {Key key,
      this.thumbnail,
      this.title,
      this.subtitle,
      this.author,
      this.publishDate,
      this.statusSecPos,
      this.color,
      this.fontSize,
      this.statusSec})
      : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String statusSecPos;
  final Color color;
  final double fontSize;
  final List<Widget> statusSec;

  @override
  Widget build(BuildContext context) {
    var _defaultSize = AppSetting.settingBtnNoSC(context)['fontSize'];
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          height: title == null ? 30 : 90,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: thumbnail == null ? false : true,
                child: AspectRatio(aspectRatio: 1, child: thumbnail),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 1.0, 0.0),
                  child: _ArticleDescription(
                    title: title,
                    subtitle: subtitle,
                    author: author,
                    publishDate: publishDate,
                    statusSecPos: statusSecPos,
                    fontSize: fontSize != null ? fontSize : _defaultSize,
                    statusSec: statusSec,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
