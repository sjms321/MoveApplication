import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';


class Reservation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(
                "예약",
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
      ),
    );
  }
}