import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roadtrax/src/blocs/bloc.dart';
import 'package:roadtrax/src/common/common.dart';
import 'package:roadtrax/src/models/models.dart';

class SmsVerificationScreen extends StatefulWidget {
  final ScrollController cont1;
  final ScrollController cont2;

  SmsVerificationScreen({this.cont1, this.cont2});

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
        bloc.resetAuthentication();
        widget.cont1.animateTo(
          0,
          duration: Duration(milliseconds: 1000),
          curve: Curves.decelerate,
        );
      },
      child: ListView(
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
          StreamBuilder<AuthState>(
              stream: bloc.authState$,
              builder: (context, snapshot) {
                AuthState state = snapshot.data;
                bool isLoading = state == AuthState.SmsVerificationLoading;
                return CustomRoundedButton(
                  isLoading: isLoading,
                  text: "VERIFY CODE",
                  onPressed: () {
                    bloc.verifySmsCode();
                    textFieldFocusNode.unfocus();
                  },
                );
              })
          // _SignInButton(),
        ],
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
      onChanged: bloc.changeSmsCode,
      inputType: TextInputType.number,
    );
  }
}
