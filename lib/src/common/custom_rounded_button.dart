import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const CustomRoundedButton({Key key, @required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 264,
      height: 56,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(200))),
        child: Text("Sign In"),
        color: Color(0xFFF60068),
        textColor: Colors.white,
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
