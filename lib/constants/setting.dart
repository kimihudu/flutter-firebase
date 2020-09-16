import 'package:flutter/material.dart';
import 'package:grocery_app/helper/responsive.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/routing/route_names.dart';

import 'enum.dart';

class AppSetting {
  static final orderStatus = {
    OrderStatus.CANCELLED: 'cancelled',
    OrderStatus.COMPLETED: 'completed',
    OrderStatus.PENDING: 'pending',
  };

  static final statusCode2Note = {
    0: 'Customer unabled to arrange for delivery',
    1: 'Customer didn\'t show up',
    2: 'Didn\'t like product',
    3: 'Unabled to pay',
    4: 'Order changed',
    5: 'Out of stock',
    6: 'Unsafe/scam',
    7: 'na',
  };
  static final statusNoteCodeList = [
    statusCode2Note[0],
    statusCode2Note[1],
    statusCode2Note[2],
    statusCode2Note[3],
    statusCode2Note[4],
    statusCode2Note[5],
    statusCode2Note[6],
    statusCode2Note[7],
  ];
  static final statusNote2Code = {
    'Customer unabled to arrange for delivery': 0,
    'Customer didn\'t show up': 1,
    'Didn\'t like product': 2,
    'Unabled to pay': 3,
    'Order changed': 4,
    'Out of stock': 5,
    'Unsafe/ Scam': 6,
    'na': 7,
  };

  static final routesIndex2Name = {
    0: HomeRoute,
    1: StoreRoute,
    2: ProdsRoute,
    3: MyCartRoute,
    4: MyAccRoute,
    5: ProdDetailRoute,
  };

  static const String STORETAB = '';
  static const String PRODSTAB = '';
  static const String CARTTAB = '';
  static const String ACCOUNTTAB = '';

  static const List CATEGORIES = [
    {"id": "1", "name": "Indica", "img": ""},
    {"id": "2", "name": "Indica Hybrid", "img": ""},
    {"id": "5", "name": "Edibles", "img": ""},
    {"id": "3", "name": "Sativa", "img": ""},
    {"id": "4", "name": "Sativa Hybrid", "img": ""},
  ];

  static bool openTime() {
    if (Helper.getCurrentHour() >= 11 &&
        Helper.getCurrentHour() <= (22 + 2 / 3)) return true;
    return false;
  }

  //setting for button number of game single column: s4c,s3c
  static Map<String, dynamic> settingBtnNoSC(BuildContext context) {
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

  static String appSlogun = "WELCOME TO LUCKY WORLD";
  static String itSupport = "IT Support TEXT ONLY *416-871-7231";
  static String changePw =
      'To change password\nEnter the new password then click change password.';

  static String confirmPaymentText =
      'Please view the History to confirm your ticket. Contact IT support TEXT ONLY *416-871-7231 before 11pm if you don\'t see your ticket.\nWe\'re not responsible for lost tickets.';

  static String confirmPaymentTitleText = "Your Ticket Submitted";
  static String resetPassConfirm =
      "Your request for Password change has been successfully updated.";
  static String resetEmailConfirm =
      "Your request for Email change has been successfully updated.";
  static String changePwEmailDescript =
      '*Enter your email to receive your daily report by email.';
  static String errMsg = 'Your Password Is ncorrect.';
  static String topupWinning =
      'Are you sure to topup your account from this winning ticket?';
  static String topupWinningConfirm =
      'Please allow a minute for the system to transfer your winning to topup credit.';
  static String regExpEmail =
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'; //'^[a-zA-Z0-9_.+-]@[a-zA-Z0-9-]\.[a-zA-Z0-9-]\$';
  static String regExpPhone = '^(?:[+0]9)?[0-9]{10}\$';
  static String invalidDiceText =
      'There are invalid numbers between 40-50 for LuckyDice.\nPlease remove this lines first.';
  static String invalidSixGrandText =
      'The number 50 is invalid for LuckySix and LuckyGrand.\nPlease remove this lines first.';
  static String termConditionHeaderText = 'Dear value player';
  static String termConditionText =
      'Please keep in mind that our system will close at 10:30pm. Please contact IT support before 11pm if you don\'t see your ticket in the History after submitting your ticket and we will look into it. All tickets submit after closing time are not valid.\nThank You & Best Luck to you.';
  static String termConditionFooterText = 'Thank You & Best Luck to you.';
  static String ticketProcessText =
      'Please wait while your ticket is being processed. Also, contact us before 11:00pm if you don\'t see your ticket in the History. We\'re not responsible for lost ticket after 11pm.';
  static String smsTemplate(String cusName, String content, String profile,
      [String frStoreNo]) {
    return 'Hi $cusName,\n$content\n***DO NOT REPLY***\nThank You\nContact: $frStoreNo';
  }

  static String smsTextRes = 'Message queued successfully';

  static String formatDate = 'MMM d E'; //* Jul 31 Fri

  static double headlineSize = 72;
  static double titleSize = 36;
  static double bodySize = 14;
  static double numPadRatio = 3 / 4;

  static int waitFrSecond = 15;

  // ----------version---------------
  // v-YYYYMMDD-N|D-Q1|2|3|4
  // static String version = '__v20200523dq1';
  static String version = '__v20200817dq4';
  static final bool devOpt = true;
// ----------firebase---------------
  static const firebaseConfig = {
    'apiKey': 'AIzaSyDijChjqWcCk0w65OMN5MFtzCrjVJ9r5lM',
    'authDomain': '', //<your-auth-domain>
    'databaseURL': 'https://s3s-flutter.firebaseio.com', //<your-database-url>
    'storageBucket': 'gs://s3s-flutter.appspot.com',
    'projectId': 's3s-flutter',
    'googleAppID':
        '984838772349-b17qdfa76rtc8b7u38dmb525itba8mn4.apps.googleusercontent.com'
  };
  //-----------firebase--------------
  static final dirCredential = "POS/credential/";
  static final usrName = "Lucky";
  static final passWrd = "175501";
  static final reqFolder = "Acct";
  static final upFolder = "Ticket";
  static final topFolder = "Topup";
  static final repFolder = "Replay";
}
