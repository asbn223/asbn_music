import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color, textColor;
  final String text;
  final Function press;

  RoundedButton({
    this.color,
    this.textColor,
    this.press,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 40,
          ),
          color: color,
          onPressed: () => press(),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
