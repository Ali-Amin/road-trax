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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": _buildScreen,
        },
      ),
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
            return LoginScreens();
            break;

          default:
            return LoginScreens();
            break;
        }
      },
    );
  }
}
