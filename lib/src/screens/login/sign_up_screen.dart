import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roadtrax/src/blocs/bloc.dart';
import 'package:roadtrax/src/common/common.dart';

class SignUpScreen extends StatefulWidget {
  final ScrollController cont;
  SignUpScreen({this.cont});

  @override
  _SignUpScreenState createState() {
    return new _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      body: ListView(
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
