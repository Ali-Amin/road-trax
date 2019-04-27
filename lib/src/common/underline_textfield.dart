import 'package:flutter/material.dart';

class UnderLineTextField extends StatelessWidget {
  final String hintText;
  final String label;
  final IconData icon;
  final Function(String) onChanged;
  final FocusNode focusNode;
  const UnderLineTextField({
    Key key,
    @required this.hintText,
    @required this.icon,
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
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: Colors.white.withAlpha(100)),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.white.withAlpha(100)),
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
