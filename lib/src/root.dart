import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roadtrax/src/blocs/bloc.dart';
import 'package:roadtrax/src/models/models.dart';
import 'package:roadtrax/src/screens/screens.dart';

class RoadTrax extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      value: Bloc(),
      child: MaterialApp(routes: {
        "/": _buildScreen,
      }),
    );
  }

  Widget _buildScreen(BuildContext context) {
    Bloc bloc = Provider.of<Bloc>(context);
    return StreamBuilder<AuthState>(
      stream: bloc.authState$,
      initialData: AuthState.Loading,
      builder: (context, snapshot) {
        AuthState authState = snapshot.data;

        switch (authState) {
          case AuthState.Loading:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
            break;
          case AuthState.Initial:
            return PhoneLoginScreen();
            break;
          case AuthState.PhoneLoginError:
            return PhoneLoginScreen();
            break;
          case AuthState.SmsSent:
            return SmsVerificationScreen();
            break;
          case AuthState.SmsVerificationError:
            return SmsVerificationScreen();
            break;
          case AuthState.SmsVerified:
            return PhoneLoginScreen();
            break;
          case AuthState.UserDoesNotExist:
            return SignUpScreen();
            break;
          case AuthState.Authenticated:
            return Scaffold(); // Home Screen
            break;
          case AuthState.PhoneLoginLoading:
            return PhoneLoginScreen();
            break;
          case AuthState.SmsVerificationLoading:
            return SmsVerificationScreen();
            break;
          default:
            return PhoneLoginScreen();
            break;
        }
      },
    );
  }
}
