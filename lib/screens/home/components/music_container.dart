import 'package:flutter/material.dart';

class MusicContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey,
            ),
            Container(
              height: 45,
              width: double.infinity,
              color: Colors.white,
              child: Text("Sabin"),
            ),
          ],
        ),
      ),
      height: 150,
      width: 125,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}
