import 'package:flutter/material.dart';

class UnderLineTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function(String) onChanged;
  const UnderLineTextField({
    Key key,
    @required this.hintText,
    @required this.icon,
    this.onChanged,
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
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              width: 280,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.black.withAlpha(100),
        ),
      ],
    );
  }
}
