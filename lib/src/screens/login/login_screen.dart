import 'package:flutter/material.dart';
import 'package:roadtrax/src/blocs/bloc.dart';
import 'package:provider/provider.dart';
import 'package:roadtrax/src/common/common.dart';
import 'package:roadtrax/src/models/models.dart';
import 'package:roadtrax/src/screens/login/phone_login_screen.dart';
import 'package:roadtrax/src/screens/login/sign_up_screen.dart';
import 'package:roadtrax/src/screens/login/sms_verification_screen.dart';

class LoginScreens extends StatefulWidget {
  @override
  _LoginScreensState createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  ScrollController cont1;
  ScrollController cont2;

  @override
  void initState() {
    cont1 = PageController();
    cont2 = PageController();
    super.initState();
  }

  @override
  void dispose() {
    cont1.dispose();
    cont2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of<Bloc>(context);
    bloc.authState$.distinct().listen((AuthState authState) {
      switch (authState) {
        case AuthState.SmsSent:
          cont1.animateTo(
            MediaQuery.of(context).size.height,
            duration: Duration(milliseconds: 1000),
            curve: Curves.decelerate,
          );
          break;
        case AuthState.UserDoesNotExist:
          cont2.animateTo(
            MediaQuery.of(context).size.width,
            duration: Duration(milliseconds: 1000),
            curve: Curves.decelerate,
          );
          break;
        case AuthState.Authenticated:
          break;
          break;
        default:
          break;
      }
    });
    return Scaffold(
      backgroundColor: Color(0xFF121A27),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: cont2,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: cont1,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              PhoneLoginScreen(cont: cont1),
              SmsVerificationScreen(
                cont1: cont1,
                cont2: cont2,
              ),
            ],
          ),
          SignUpScreen(
            cont1: cont1,
            cont2: cont2,
          )
        ],
      ),
    );
  }
}
