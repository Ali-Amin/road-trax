import 'package:flutter/material.dart';
import 'package:roadtrax/src/blocs/bloc.dart';
import 'package:provider/provider.dart';
import 'package:roadtrax/src/common/common.dart';

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

class PhoneLoginScreen extends StatefulWidget {
  final ScrollController cont;
  PhoneLoginScreen({this.cont});

  @override
  PhoneLoginScreenState createState() {
    return new PhoneLoginScreenState();
  }
}

class PhoneLoginScreenState extends State<PhoneLoginScreen> {
  FocusNode textFieldFocusNode;

  @override
  void initState() {
    textFieldFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of<Bloc>(context);
    return Scaffold(
      backgroundColor: Color(0xFF121A27),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        curve: Curves.decelerate,
        transform: Matrix4.translationValues(0, 0, 100),
        child: ListView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20.0,
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          children: <Widget>[
            Icon(
              Icons.person_outline,
              size: 200.0,
              color: Color(0xFFF60068),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70.0),
              child: _PhoneNumberTextField(
                focusNode: textFieldFocusNode,
              ),
            ),
            CustomRoundedButton(
              text: "SEND SMS CODE",
              onPressed: () {
                textFieldFocusNode.unfocus();
                bloc.sendSmsCode();
                widget.cont.animateTo(
                  MediaQuery.of(context).size.height,
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.decelerate,
                );
              },
            )
            // _SignInButton(),
          ],
        ),
      ),
    );
  }
}

class _PhoneNumberTextField extends StatelessWidget {
  final FocusNode focusNode;
  _PhoneNumberTextField({this.focusNode});
  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of<Bloc>(context);
    return UnderLineTextField(
      label: "Phone Number",
      focusNode: focusNode,
      icon: Icons.phone_android,
      hintText: "eg. 01112345678",
      onChanged: bloc.changePhoneNumber,
    );
  }
}

class SmsVerificationScreen extends StatefulWidget {
  final ScrollController cont;
  SmsVerificationScreen({this.cont});

  @override
  SmsVerificationScreenState createState() {
    return new SmsVerificationScreenState();
  }
}

class SmsVerificationScreenState extends State<SmsVerificationScreen> {
  FocusNode textFieldFocusNode;
  @override
  void initState() {
    textFieldFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of<Bloc>(context);
    return WillPopScope(
      onWillPop: () async {
        widget.cont.animateTo(
          -MediaQuery.of(context).size.height * 0.1,
          duration: Duration(milliseconds: 1000),
          curve: Curves.decelerate,
        );
      },
      child: Scaffold(
        backgroundColor: Color(0xFF121A27),
        body: ListView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20.0,
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          children: <Widget>[
            Icon(
              Icons.check,
              size: 200.0,
              color: Color(0xFFF60068),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70.0),
              child: _SmsVerificationTextField(
                focusNode: textFieldFocusNode,
              ),
            ),
            CustomRoundedButton(
              text: "VERIFY CODE",
              onPressed: () {
                textFieldFocusNode.unfocus();
                bloc.sendSmsCode();
                widget.cont.animateTo(
                  MediaQuery.of(context).size.height,
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.decelerate,
                );
              },
            )
            // _SignInButton(),
          ],
        ),
      ),
    );
  }
}

class _SmsVerificationTextField extends StatelessWidget {
  final FocusNode focusNode;
  _SmsVerificationTextField({this.focusNode});
  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of<Bloc>(context);
    return UnderLineTextField(
      focusNode: focusNode,
      icon: Icons.mail_outline,
      hintText: "eg. 123456",
      label: "SMS Code",
      onChanged: bloc.changePhoneNumber,
    );
  }
}
