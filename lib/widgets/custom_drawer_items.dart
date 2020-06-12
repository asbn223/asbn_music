import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawerItems extends StatelessWidget {
  final String title, imageUrl;
  final IconData icon;
  final Color color;
  final Function onTap;

  CustomDrawerItems({
    this.title,
    this.imageUrl,
    this.icon,
    this.color,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ListTile(
        onTap: onTap,
        leading: icon == null
            ? Image.asset(
                imageUrl,
                width: 25,
              )
            : Icon(
                icon,
                size: 25,
                color: color,
              ),
        title: Text(
          title,
          style: GoogleFonts.getFont(
            'Bellota',
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
