import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';

class ClayButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color color, iconColor;

  ClayButton({
    this.icon,
    this.onPressed,
    this.color = const Color(0xFFC44569),
    this.iconColor = const Color(0xFFFFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      depth: 50,
      width: 50,
      height: 50,
      borderRadius: 50,
      color: color,
      child: IconButton(
        alignment: Alignment.center,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
        ),
        iconSize: 25,
      ),
    );
  }
}
