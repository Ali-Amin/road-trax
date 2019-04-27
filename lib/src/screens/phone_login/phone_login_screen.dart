import 'package:flutter/material.dart';
import 'package:roadtrax/src/blocs/bloc.dart';
import 'package:provider/provider.dart';

class PhoneLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of<Bloc>(context);
    return Center(
      child: TextField(
        onChanged: bloc.changePhoneNumber,
        onSubmitted: (String phoneNumber) {
          bloc.sendSmsCode();
        },
      ),
    );
  }
}
