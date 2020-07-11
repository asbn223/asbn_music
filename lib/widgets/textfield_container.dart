import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/provider/setting_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TextFieldContainer extends StatefulWidget {
  final double margin;
  final ValueChanged<String> onChanged;
  bool obscureText;
  final String text;
  final IconData icon, suffixIcon;

  TextFieldContainer({
    this.margin,
    this.onChanged,
    this.obscureText = false,
    this.text,
    this.icon,
    this.suffixIcon,
  });

  @override
  _TextFieldContainerState createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final settings = Provider.of<Settings>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: widget.margin),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
        border: Border.all(
          style: BorderStyle.solid,
          color: settings.isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF000000),
        ),
        color: settings.isDarkMode ? Color(0xFF000000) : Color(0xFFDFE4EA),
      ),
      child: TextField(
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          icon: Icon(widget.icon),
          hintText: widget.text,
          border: InputBorder.none,
          suffixIcon: widget.suffixIcon == null
              ? null
              : IconButton(
                  icon: Icon(
                      isVisible ? Icons.visibility_off : widget.suffixIcon),
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                      isVisible = !isVisible;
                    });
                  },
                ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
