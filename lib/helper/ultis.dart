import 'dart:convert';
import 'dart:html' as html;
import 'dart:js';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'package:grocery_app/constants/setting.dart';
import 'package:grocery_app/models/models.dart';
import 'package:intl/intl.dart';

import 'responsive.dart';

class Helper {
  static num tryParse(String input) {
    String source = input.trim();
    return int.tryParse(source) ?? double.tryParse(source);
  }

  static isNumeric(string) => num.tryParse(string) != null;

  /**
   * 042920lk - add opt dev
   * */
  static debugLog(screen, msg, [bool dev = true]) {
    dev = AppSetting.devOpt;
    if (dev) print('debug_log: $screen : $msg');
  }

  static Future<Null> submitDialog(BuildContext context) async {
    return await showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        });
  }

  static int crossFontSize(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    var deviceMin;
    _width > _height ? deviceMin = _height : deviceMin = _width;
    // say we want base font size: 16px @ 600px (min of 800x600); 16/600 = 0.0266667
    return (0.0267 * deviceMin).round();
  }

  static double crossGap(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    var deviceMin;
    _width > _height
        ? deviceMin = _height / _width
        : deviceMin = _width / _height;
    // say we want base font size: 16px @ 600px (min of 800x600); 16/600 = 0.0266667
    return deviceMin;
  }

  static double responsive(
      {@required BuildContext context,
      double small = 1,
      double med = 2,
      double large = 3}) {
    double _size = MediaQuery.of(context).size.width <= 400.0
        ? small
        : MediaQuery.of(context).size.width >= 1000.0 ? large : med;
    return _size;
  }

  static double responsiveH(
      {@required BuildContext context,
      double small = 1,
      double med = 2,
      double large = 3}) {
    double _size = MediaQuery.of(context).size.height <= 600.0
        ? small
        : MediaQuery.of(context).size.height >= 1000.0 ? large : med;
    return _size;
  }

  /// This is convert gridview auto generate No to lucky No
  /// range: 0-55; extral: quick view btn, 4 empty btn
  /// col: 5
  static int exchangeF5ColNo({int input, List<int> offNo}) {
    var _defaultStart = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50];
    int _magicNo1 = 4; // <-- this the gap of gridview auto No vs lucky No
    int _magicNo2 = 5; // <-- this is the minimum No of second line gridview
    int _iterVertical = input ~/ _magicNo2;
    int _startNo = _defaultStart[_iterVertical];
    int _iterHorizontal = input - _startNo;
    final _offNo = offNo;
    int _return;

// _iterVertical
    // [0-4]; 0
    // [5-9]; 1
    // [10-14]; 2

// __iterHorizontal
// startNo = 5 --> gap nextNo = 6-startNo , nextNo = 7-startNo
// [0,1,2,3,4]

// _first = _startNo - (_magicNo1 * _iterVertical);

    if (_iterVertical == 0) {
      _return = input * 10;
    } else if (_iterVertical != 0) {
      if (_defaultStart.contains(input))
        _return =
            _startNo - (_magicNo1 * (_iterVertical)); // <--keep the start No
      else
        _return = _startNo -
            (_magicNo1 * (_iterVertical)) +
            _iterHorizontal *
                10; // <-- loop horizontal with same iterVertiacal and increase iterHorizontal
    }

    // Helper.debugLog('exchange5ColNo', '$input - $_return');
    if (_offNo.contains(input)) {
      _return = -1;
    }
    return _return;
  }

  /// This is convert gridview auto generate No to lucky No
  /// range: 0-40;
  /// col: 4
  static int exchangeF4ColNo({int input, List<int> offNo}) {
    var _defaultStart = [0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40];
    int _magicNo1 = 3; // <-- this the gap of gridview auto No vs lucky No
    int _magicNo2 = 4; // <-- this is the minimum No of second line gridview
    int _iterVertical = input ~/ _magicNo2;
    int _startNo = _defaultStart[_iterVertical];
    int _iterHorizontal = input - _startNo;
    final _offNo = offNo;
    int _return;

    if (_iterVertical == 0) {
      _return = input * 10;
    } else if (_iterVertical != 0) {
      if (_defaultStart.contains(input))
        _return =
            _startNo - (_magicNo1 * (_iterVertical)); // <--keep the start No
      else
        _return = _startNo -
            (_magicNo1 * (_iterVertical)) +
            _iterHorizontal *
                10; // <-- loop horizontal with same iterVertiacal and increase iterHorizontal
    }

    // Helper.debugLog('exchange5ColNo', '$input - $_return');
    if (_offNo.contains(input)) {
      _return = -1;
    }
    return _return;
  }

  /// This is convert gridview auto generate No to lucky No
  /// range: 0-40;
  /// col: 4
  static int exchangeS4ColNo({int input, List<int> offNo}) {
    var _defaultStart = [0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40];
    int _magicNo1 = 3; // <-- this the gap of gridview auto No vs lucky No
    int _magicNo2 = 4; // <-- this is the minimum No of second line gridview
    int _iterVertical = input ~/ _magicNo2;
    int _startNo = _defaultStart[_iterVertical];
    // int _iterHorizontal = input - _startNo;
    final _offNo = offNo;
    int _return;

    if (_iterVertical < 0) {
      _return = input;
    } else {
      _return =
          _startNo - (_magicNo1 * (_iterVertical)); // <--keep the start No

      // <-- loop horizontal with same iterVertiacal and increase iterHorizontal
    }

    // Helper.debugLog('exchange5ColNo', '$input - $_return');
    if (_offNo.contains(input)) {
      _return = -1;
    }
    // Helper.debugLog('exchangeS4ColNo', _return);
    return _return;
  }

  /// This is convert gridview auto generate No to lucky No
  /// range: 0-30;
  /// col: 3
  static int exchangeS3ColNo({int input, List<int> offNo}) {
    var _defaultStart = [0, 3, 6, 9, 12, 15, 18, 21, 24, 27];
    int _magicNo1 = 2; // <-- this the gap of gridview auto No vs lucky No
    int _magicNo2 = 3; // <-- this is the minimum No of second line gridview
    int _iterVertical = input ~/ _magicNo2;
    int _startNo = _defaultStart[_iterVertical];
    // int _iterHorizontal = input - _startNo;
    final _offNo = offNo;
    int _return;

    if (_iterVertical < 0) {
      _return = input;
    } else {
      _return =
          _startNo - (_magicNo1 * (_iterVertical)); // <--keep the start No

      // <-- loop horizontal with same iterVertiacal and increase iterHorizontal
    }

    // Helper.debugLog('exchange5ColNo', '$input - $_return');
    if (_offNo.contains(input)) {
      _return = -1;
    }
    // Helper.debugLog('exchangeS4ColNo', _return);
    return _return;
  }

  static String generateBtnNo({String layoutType, int input, List<int> offNo}) {
    String _returnStr;
    int _returnNo;
    switch (layoutType) {
      case 'f5c':
        _returnNo = exchangeF5ColNo(input: input, offNo: offNo);
        _returnNo == -1
            ? _returnStr = ''
            : _returnNo == 0
                ? _returnStr = 'Quick'
                : _returnNo < 10 && _returnNo > 0
                    ? _returnStr = '0' + _returnNo.toString()
                    : _returnStr = _returnNo.toString();
        break;
      case 'f4c':
        _returnNo = exchangeF4ColNo(input: input, offNo: offNo);
        _returnNo == -1
            ? _returnStr = ''
            : _returnNo == 0
                ? _returnStr = 'Quick'
                : _returnNo < 10 && _returnNo > 0
                    ? _returnStr = '0' + _returnNo.toString()
                    : _returnStr = _returnNo.toString();
        break;
      case 's4c':
        _returnNo = exchangeS4ColNo(input: input, offNo: offNo);
        _returnStr = _returnNo.toString();

        break;
      case 's3c':
        _returnNo = exchangeS3ColNo(input: input, offNo: offNo);
        _returnStr = _returnNo.toString();
        break;
    }

    return _returnStr;
  }

/**
 * check gap between no in line
 * make sure no gap for 3 or 4
 * 
*/
  static bool checkGapNoSC(List listNum, int layoutCol) {
    var _gapNum = layoutCol;

    for (var i = 0; i < listNum.length; i++) {
      return listNum[i + 1] - listNum[i] != _gapNum;
    }
    return false;
  }

  static bool checkTicketPattern(
      String pattern, String ticket, String gameType) {
    if (ticket == '' || ticket == null || ticket.length <= 0) {
      return false;
    } else if (!gameType.contains("BO") && !gameType.contains("BOX")) {
      var _minCombination = gameType.split("")[1];
      var _ticketCombination = ticket.split("-").length;
      return _ticketCombination >= int.parse(_minCombination);
    } else if (pattern.split('-').length <= 4) {
      //check for pick4 and pick123
      RegExp regExp = new RegExp(
        pattern,
        caseSensitive: false,
        multiLine: false,
      );
      return regExp.hasMatch(ticket);
    } else {
      return true; //<-- this for BO
    }

    //check absolute condition
    // r'\d{1,2}\-\d{1,2}\-\d{1,2}\-\d{1,2}\-\d{1,2}\-\d{1,2}\-\d{1,2}\-\d{1,2}'
    // var _numCombination = gameType.split("")[1];
    // var _pattern = "r'" +
    //     (pattern.split("_").sublist(0, int.parse(_numCombination))).join("_") +
    //     "'";
    // Helper.debugLog('check pattern', _pattern);
    // RegExp regExp = new RegExp(
    //   _pattern,
    //   caseSensitive: false,
    //   multiLine: false,
    // );
    // return regExp.hasMatch(ticket);
  }

  static String deleteStr(String txt, int pos, String AppSetting) {
    var _txt = txt.split('-');
    var _index;

    if (pos <= 0) return txt; //<-- handle for first pos

    switch (AppSetting) {
      case 'f5c':
      case 'f4c':
        _index = ((pos + 1) / 3).round(); //<-- (3x - 1) = string.length
        break;
      case 's4c':
      case 's3c':
        _index = ((pos + 1) / 2).round(); //<-- (2x - 1) = string.length
        break;
    }
    _txt.removeAt(_index - 1); // <-- list start from 0
    return _txt.map((e) => e.toString()).join('-');
  }

  static List randomNo(int expPairNo, int rangeNo) {
    var rng = new Random();
    var _randomList =
        new List.generate(expPairNo, (_) => rng.nextInt(rangeNo) + 1);
    return _randomList;
  }

//generate quickpick number
//050920lk - opt quickpick: 5,8,10
  // static String quickPick(int gameNo, [int range]) {
  //   debugLog('ultis > quickPick > number $gameNo', 'range > $range');
  //   var _noOfPair;
  //   if (range == null) {
  //     _noOfPair =
  //         AppSetting.maxCombination; //<-- quick btn just for game has 10 pairs
  //   } else {
  //     _noOfPair = range;
  //   }

  //   List _randomList;
  //   List _uniqueList;
  //   do {
  //     _randomList = randomNo(_noOfPair, gameNo);
  //     _uniqueList = Set.of(_randomList).toList();
  //   } while (_randomList.length != _uniqueList.length);

  //   return _uniqueList
  //       .map((e) => e < 10 ? '0' + e.toString() : e.toString())
  //       .join('-');
  // }

  ///TODO: get data callback by a future async
  static Future<String> baseDialog(BuildContext context,
      List<Widget> actionWidgets, Widget titleDial, Widget contentDial,
      [double size]) async {
// set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: titleDial,
      content: Builder(
        builder: (context) {
          if (size == null) size = AppSetting.settingBtnNoSC(context)['height'];
          return Container(
            // height: size * 1 / 2,
            width: size * 2,
            child: contentDial,
          );
        },
      ),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      actions: actionWidgets,
    );

    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: alert,
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {},
    );
  }

  static Future<String> oopAlert(BuildContext context, String title, String msg,
      [bool isConfirm = false, Widget widget]) async {
    var wrapperTitle;
    var wrapperSubTitle;
    title == 'k' ? wrapperTitle = widget : wrapperTitle = Text('$title');
    msg == 'k' ? wrapperSubTitle = widget : wrapperSubTitle = Text('$msg');
    // set up the button
    Widget yesButton = Visibility(
        visible: isConfirm && msg == 'k' ? false : true,
        child: RaisedButton(
          color: Colors.redAccent,
          child: Text("OK"),
          onPressed: () {
            // debugLog('oopAlert', context);
            Navigator.of(context, rootNavigator: true).pop('ok');
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
          ),
        ));
    Widget noButton = Visibility(
      visible: isConfirm && msg != 'k' ? true : false,
      child: RaisedButton(
        color: Colors.redAccent,
        child: Text("Cancel"),
        onPressed: () {
          // debugLog('oopAlert', context);
          Navigator.of(context, rootNavigator: true).pop('no');
        },
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
      ),
    );
    var size = MediaQuery.of(context).size.width;
    return baseDialog(
        context, [noButton, yesButton], wrapperTitle, wrapperSubTitle, size);
  }

  static int getCurrentSes() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  static String random4Degit() {
    var string = DateTime.now().millisecondsSinceEpoch.toString();
    var _digit = string.substring(string.length - 4, string.length);
    Helper.debugLog('helper > random4Degit > return', _digit);
    return _digit;
  }

/**
 * convert current date follow to format
 * https://stackoverflow.com/questions/34910686/how-can-i-get-the-current-date-w-o-hour-and-minutes
*/
  static String getCurrentDate([String format]) {
    final current = new DateTime.now();
    switch (format) {
      case 'mmddyy':
        return "${current.month.toString().padLeft(2, '0')} ${current.day.toString().padLeft(2, '0')} ${current.year.toString().padLeft(2, '0')}";
        break;
      case 'mdE':
        return DateFormat(AppSetting.formatDate).format(current);
        break;
      default:
        return "${current.year.toString().padRight(2)}${current.month.toString().padLeft(2, '0')}${current.day.toString().padLeft(2, '0')}";
    }
  }

  static double getCurrentHour() {
    final current = new DateTime.now();
    return current.hour + (current.minute) / 60;
  }

  static String getCurrentHourMinute() {
    final current = new DateTime.now();
    return '${current.hour}${current.minute}';
  }

  static String str2Date(String _string, [String format]) {
    var _m = _string.substring(0, 2);
    var _d = _string.substring(2, 4);
    var _y = _string.substring(4, 8);
    return DateFormat("E_dd_MM").format(DateTime.parse('$_y\-$_m\-$_d'));
  }

//042320lk - update for new file name structure
  static bool checkFileName(String fileName) {
    //fileName has structure:
    //local_5_6477193108_0_b93c5d50-72cb-11ea-9b32-ff7142f4636b.json
    //r'\local\_\d\_\d{10}\_\d\_\w+\-\w+\-\w+\-\w+\-\w+\.json';
    //042320lk - update file name structure
    //mmddyy_expensive_phone_hhmm_uuid.json
    // r'\w{6}\_\w+\_\d{10}\_\d{4}\_\w+\-\w+\-\w+\-\w+\-\w+\.json';
    String wordToFind =
        r'\w{6}\_\w+\_\d{10}\_\d+\_\w+\-\w+\-\w+\-\w+\-\w+\.json';

    RegExp regExp = new RegExp(
      wordToFind,
      caseSensitive: false,
      multiLine: false,
    );
    final _return = regExp.hasMatch(fileName);

    return _return;
  }

  static String getFileName(String path) {
    return path?.split('/')?.last;
  }

  //042320lk - update add time from file name
  //v042520d
//   static List<String> fileName2GameHistoryInfo(String fileName) {
//     //mmddyy_expensive_phone_hhmm_uuid.json
//     List<String> _return = new List();
//     if (checkFileName(fileName)) {
//       int posMoney = fileName.indexOf("_");
//       int posPhone = fileName.indexOf('_', posMoney + 1);
//       int posTime = fileName.lastIndexOf('_');
// //            int pos_unique = fileName.indexOf('-');
//       String _money = fileName.substring(posMoney + 1, posPhone);
//       String _ticketNo = fileName.substring(posPhone + 1, posTime);
//       String _date = fileName.substring(0, posMoney);

//       _return.add(_money);
//       _return.add(_ticketNo);
//       _return.add(_date);
//     }
//     return _return;
//   }

  // v041520n
  /**
   * 042520lk - update history dir structure follow phone num
   * **/
  static List<String> fileName2GameHistoryInfo(String fileName) {
    //mmddyy_expensive_phone_hhmm_uuid.json
    List<String> _return = new List();

    var selfCheck = (fileName.split('.json')[0]).split('_'); //<--remove .json
    if (selfCheck.length == 5) {
      String _money = selfCheck[2];
      String _ticketNo = '${selfCheck[3]}_${selfCheck[4]}';
      String _date = '${selfCheck[0]}_${selfCheck[1]}';

      _return.add(_money);
      _return.add(_ticketNo);
      _return.add(_date);
    }
    return _return;
  }
/**
 * 042620lk - en/decrypt
*/

  static String balooCrypt(dynamic string, [String action = 'e']) {
    //lucky.hashCode-pass-888.hashCode
    //248585644-1234-447627545
    var key1 = 'lucky'; //hashCode length always 9
    var key2 = '888';

    if (action == 'e') {
      return '${key1.hashCode}$string${key2.hashCode}';
    } else if (action == 'd') {
      return string.substring(9, 13);
    }
    return null;
  }

  /**
   * 042720lk - validate  combination
   * recursive factorial
  */

  static int findFact(int number) {
    // Helper.debugLog('Ultis > findFact > number', number);
    // if (number == 1 || number == 0) return 1;
    if (number <= 0) return 1;
    return number * findFact(number - 1);
  }

  /**
   * 042720lk - validate combination
   * input String param
   * input String amount
   * output 0: pass, minAmount: fail
   * ex: 
   * C2: n! / (2*(n-2)!)
   * C3: n! / (6*(n-3)!) 
   * C4: n! / (24*(n-4)!)  
   * p4 BOX 4!/(nD!k)
   * p3 BOX 3!/(nD!k)
   * 
  */
  // static double getMinOfNCom(String pickedNum, String amount, String gameType) {
  //   var numOfCom;
  //   var minAmountBase = AppSetting.minAmount;

  //   numOfCom = getNComOf(pickedNum, gameType);

  //   var minAmount = numOfCom * minAmountBase;

  //   var _return;
  //   var _roundMin = double.parse(minAmount.toStringAsFixed(3));
  //   double.parse(amount) >= minAmount ? _return = 0 : _return = _roundMin;

  //   return _return;
  // }

  /**
   * 051120lk - get base min of n com
  */
  // static double getBaseMinOfNCom(
  //     String pickedNum, String amount, String gameType) {
  //   var numOfCom;
  //   var minAmountBase = AppSetting.minAmount;

  //   numOfCom = getNComOf(pickedNum, gameType);

  //   var minAmount = numOfCom * minAmountBase;

  //   var _roundMin = double.parse(minAmount.toStringAsFixed(3));
  //   // double.parse(amount) >= minAmount ? _return = 0 : _return = _roundMin;

  //   return _roundMin;
  // }

/**
 * 050420lk - for BOX combination only
 * p4 BOX 4!/(nD!k)
 * p3 BOX 3!/(nD!k)
*/
  static List<int> getKNOfBox(String pickedNo) {
    var _pair = pickedNo.split('-');
    //sort
    _pair.sort((a, b) => a.compareTo(b));
    //get list of dup
    var _listDup =
        _pair.where((el) => _pair.indexOf(el) != _pair.lastIndexOf(el));
    //reduce to get list unique then count length
    var _setOfDup = _listDup.toSet().toList();

    //for special 1234
    int _nSetOfDup = _setOfDup.length == 0 ? 1 : _setOfDup.length; //k
    int _nOfDup =
        _setOfDup.length == 0 ? 1 : _listDup.length ~/ _setOfDup.length; //n

    Helper.debugLog('helper > getKNOfBox > k - n', [_nSetOfDup, _nOfDup]);
    return [_nSetOfDup, _nOfDup];
  }

/**
   * 050420lk - get combination number from picked No and gameType
   * input String pickedNo
   * input String gameType
   * output n of combination
   * ex: 
   * C1 | BO: n!
   * C2: n! / (2*(n-2)!)
   * C3: n! / (6*(n-3)!) 
   * C4: n! / (24*(n-4)!)  
   * p4 BOX 4!/(nD!k)
   * p3 BOX 3!/(nD!k)
   * k number of each n occur
   * n number of a dup, ex:22,11,111
   * ex: 1122 > k=2,nD=2
   * ex: 1112 > k=1,nD=3 
   * ex: 1223 > k=1,nD=2
   * 
   * ex: 1234 > k=1,nD=1
   * ex: 1111 > k=1,nD=4
   * 
  */
  static int getNComOf(String pickedNum, String gameType) {
    var numOfCom;
    var _type;

    var n = pickedNum.split('-').length;
    //n!
    var nFact = findFact(n);
    //C1,C2,C3,C4,BO
    switch (gameType) {
      case 'C1':
      case 'BO':
        _type = 5;
        break;
      case 'C2':
      case 'C3':
      case 'C4':
        _type = int.parse(gameType.split('')[1]);
        break;
      case 'BOX':
        _type = 0;
        break;

      default:
    }

    //(n-2)!|(n-3)!|(n-4)!
    var nTypeFact = findFact(n - _type);

    //2,6,24
    switch (_type) {
      //eliminated BO just for 4 or 3
      case 0:
        var _k = getKNOfBox(pickedNum)[0];
        var _nD = getKNOfBox(pickedNum)[1];
        //eliminated 4 or 3
        var _isPick4 = n == 4 ? 4 : 3;
        var nFact = findFact(_isPick4);
        var nDFact = findFact(_nD);

        // * p4 BOX 4!/(nD!k)
        numOfCom = nFact / (nDFact * _k);
        break;
      case 1:
        numOfCom = n;
        break;
      case 2:
        // * C2: n! / (2*(n-2)!)
        numOfCom = nFact / (2 * nTypeFact);
        break;
      case 3:
        // * C3: n! / (6*(n-3)!)
        numOfCom = nFact / (6 * nTypeFact);
        break;
      case 4:
        // * C4: n! / (24*(n-4)!)
        numOfCom = nFact / (24 * nTypeFact);
        break;
      case 5:
        //C1,BO: follow the pair they picked
        numOfCom = n;
        break;
      default:
    }
    // Helper.debugLog('helper > getNComOf > n', n);
    // Helper.debugLog('helper > getNComOf > gameType', gameType);
    Helper.debugLog('helper > getNComOf > numOfCom', numOfCom);
    return numOfCom;
  }

  /**
   * 051220lk - dedup games of player
  */
//   static void deDupPlayerGame(Player player) {
//     // List _games = player.games.sort((a, b) => a.gameName.compareTo(b.gameName));
//     var gamesDup = player.games.where(
//         (game) => player.games.indexOf(game) != player.games.lastIndexOf(game));

//     List _listickets = List();
//     if (gamesDup.length > 0) {
//       gamesDup.forEach((game) {
//         game.tickets.forEach((_ticket) {
//           _listickets.add(_ticket);
//         });
//       });
//       var _newGameName = _listickets[0].gameName;
//       Game newGame = Game(
//         gameName: _newGameName,
//         tickets: _listickets,
//         totals: '',
//       );
//       player.games.removeWhere((game) => game.gameName == _newGameName);
//       player.games.add(newGame);
//     }
//   }
  static Map<String, dynamic> settingSize(BuildContext context) {
    return {
      'btnSize': Helper.responsive(
        context: context,
        small: Responsive(context).rH(5),
        med: Responsive(context).rH(6),
        large: Responsive(context).rH(7),
      ),
      'margin': Helper.responsive(
        context: context,
        small: Helper.crossGap(context) * 8,
        med: Helper.crossGap(context) * 8,
        large: Helper.crossGap(context) * 8,
      ),
      'fontSize': Helper.responsive(
        context: context,
        small: Helper.crossFontSize(context).toDouble() + 5,
        med: Helper.crossFontSize(context).toDouble() + 5,
        large: Helper.crossFontSize(context).toDouble() + 3,
      ),
      'crossSpace': Responsive(context).rW(0.1),
      'mainSpace': Responsive(context).rW(0.2),
      'height': Helper.responsiveH(
        context: context,
        small: MediaQuery.of(context).size.height * 1 / 3 + 7,
        med: MediaQuery.of(context).size.height * 1 / 4 + 21,
        large: MediaQuery.of(context).size.height * 1 / 5,
      ),
      'ratio': Helper.responsive(
          context: context,
          small: 1,
          med: 1,
          large: Responsive(context).rW(5) / Responsive(context).rH(8))
    };
  }

/**
 * find dup in list
 * return element with postion of dup
 * [{'item':el1,'index':3},{'item':el2,'index':5}]
 * el1 start from 0 to index 3
 * el2 start after el1 to index 5
*/

  static List<dynamic> getIndexListGroup(
      List<Product> data, String filterField) {
    List _return = List();
    // Helper.debugLog('util > getIndexListGroup > list', data);

    data.sort((a, b) => b.sku.compareTo(a.sku));
    for (int i = 0; i < data.length; i++) {
      if (i == data.length - 1) {
        _return.add({'item': data[i], 'index': i});
      } else if (data[i].sku != data[i + 1].sku) {
        _return.add({'item': data[i], 'index': i});
      }
    }
    // Helper.debugLog('util > getIndexListGroup > return ', _return);
    return _return;
  }

/**
 * this func just use for func above
 * list map with ele and index pos
 * input pos want to get 
 * return map with ele and count number
 * {'item':el, 'count':input[index] - inputPrev[index]}
 * 
*/
  static Map<String, dynamic> countElementInGroup(List data, int indexEl) {
    // Helper.debugLog('util > countElementInGroup > data ', data);
    var _element = data[indexEl];
    if (indexEl == 0) {
      return {'item': _element['item'], 'count': _element['index'] + 1};
    } else {
      var _prevEl = data[indexEl - 1];
      return {
        'item': _element['item'],
        'count': _element['index'] - _prevEl['index']
      };
    }
  }

  /**
   * 062420lk - convert json map style to obj maptypestyle
   * MapTypeStyle is obj type for map created by a JsObject
   * https://developers.google.com/maps/documentation/javascript/style-reference
   * JsObject is javascript obj created by JSON like collection of Dart
   * https://api.dart.dev/stable/2.8.4/dart-js/JsObject-class.html
  */
  static List<MapTypeStyle> convertMapType(List mapStr) {
    return mapStr
        .map<MapTypeStyle>((e) => MapTypeStyle.created(JsObject.jsify(e)))
        .toList();
  }

  static String cartTotal(List<Product> data) {
    return data
        .fold(0, (prevVal, prod) => prevVal + double.parse(prod.price))
        .toString();
  }
}

class Platform {
  var _iOS = [
    'iPad Simulator',
    'iPhone Simulator',
    'iPod Simulator',
    'iPad',
    'iPhone',
    'iPod'
  ];

  bool isIOS() {
    var matches = false;
    _iOS.forEach((name) {
      if (html.window.navigator.platform.contains(name) ||
          html.window.navigator.userAgent.contains(name)) {
        matches = true;
      }
    });
    return matches;
  }

  bool isAndroid() =>
      html.window.navigator.platform == "Android" ||
      html.window.navigator.userAgent.contains("Android");

  bool isMobile() => isAndroid() || isIOS();

  String name() {
    var name = "";
    if (isAndroid()) {
      name = "Android";
    } else if (isIOS()) {
      name = "iOS";
    } else {
      name = "web";
    }
    return name;
  }

  void openStore() {
    if (isAndroid()) {
      html.window.location.href =
          "https://play.google.com/store/apps/details?id=com.marianozorilla.tap_hero";
    } else if (isIOS()) {
      html.window.location.href =
          "https://apps.apple.com/app/taphero/id463855590";
    }
  }
}

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(r'[\s\S]');
  // RegExp(
  //   r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  // );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
