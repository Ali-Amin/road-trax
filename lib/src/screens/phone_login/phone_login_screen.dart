import 'package:flutter/material.dart';
import 'package:roadtrax/src/blocs/bloc.dart';
import 'package:provider/provider.dart';
import 'package:roadtrax/src/common/common.dart';

class PhoneLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: null,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        padding: EdgeInsets.only(
          left: 20,
          right: 20.0,
          top: MediaQuery.of(context).size.height * 0.1,
        ),
        children: <Widget>[
          Icon(
            Icons.check,
            size: 200.0,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70.0),
            child: _PhoneNumberTextField(),
          ),
          _SignInButton(),
        ],
      ),
    );
  }
}

class _PhoneNumberTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of<Bloc>(context);
    return UnderLineTextField(
      icon: Icons.person_outline,
      hintText: "Phone Number eg. 01112345678",
      onChanged: bloc.changePhoneNumber,
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of<Bloc>(context);
    return CustomRoundedButton(
      text: "Sign In",
      onPressed: () {
        bloc.sendSmsCode();
      },
    );
  }
}
