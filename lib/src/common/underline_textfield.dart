import 'package:flutter/material.dart';

class UnderLineTextField extends StatelessWidget {
  final String hintText;
  final String label;
  final IconData icon;
  final Function(String) onChanged;
  final FocusNode focusNode;
  final TextInputType inputType;
  const UnderLineTextField({
    Key key,
    @required this.hintText,
    @required this.icon,
    this.inputType = TextInputType.text,
    this.label = "",
    this.onChanged,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Color(0xFFF60068),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              width: 280,
              child: TextField(
                focusNode: focusNode,
                keyboardType: inputType,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: Colors.white.withAlpha(100)),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.white.withAlpha(100)),
                ),
                style: TextStyle(
                  color: Color(0xFFF60068),
                ),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.white.withAlpha(100),
        ),
      ],
    );
  }
}
