import 'package:flutter/material.dart';
import 'package:roadtrax/src/blocs/bloc.dart';
import 'package:provider/provider.dart';
import 'package:roadtrax/src/common/common.dart';
import 'package:roadtrax/src/screens/login/phone_login_screen.dart';
import 'package:roadtrax/src/screens/login/sms_verification_screen.dart';

class LoginScreens extends StatefulWidget {
  @override
  _LoginScreensState createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  ScrollController cont;
  @override
  void initState() {
    cont = PageController();
    super.initState();
  }

  @override
  void dispose() {
    cont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: cont,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        PhoneLoginScreen(cont: cont),
        SmsVerificationScreen(cont: cont),
      ],
    );
  }
}
