import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roadtrax/src/blocs/bloc.dart';
import 'package:roadtrax/src/models/models.dart';

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
            break;
          case AuthState.Initial:
            break;
          case AuthState.PhoneLoginError:
            break;
          case AuthState.SmsSent:
            break;
          case AuthState.SmsVerificationError:
            break;
          case AuthState.SmsVerified:
            break;
          case AuthState.UserDoesNotExist:
            break;
          case AuthState.Authenticated:
            break;
          case AuthState.PhoneLoginLoading:
            break;
          case AuthState.SmsVerificationLoading:
            break;
          default:
            break;
        }
      },
    );
  }
}
