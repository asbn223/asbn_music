import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';

class ClayButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  ClayButton({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      depth: 50,
      width: 50,
      height: 50,
      borderRadius: 50,
      color: Colors.redAccent,
      child: IconButton(
        alignment: Alignment.center,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        iconSize: 25,
      ),
    );
  }
}
