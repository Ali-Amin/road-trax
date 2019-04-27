import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomRoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;
  const CustomRoundedButton({
    Key key,
    @required this.text,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 264,
      height: 56,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(200))),
        child: isLoading
            ? SpinKitWave(
                color: Colors.white,
                size: 20.0,
              )
            : Text(text),
        color: Color(0xFFF60068),
        textColor: Colors.white,
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
