import 'dart:ui';

import 'package:flutter/material.dart';

const textStyle1 = TextStyle(color: Color(0xFF000000), fontSize: 20.0);

const textStyle2 = TextStyle(
    color: Color(0xFF000000), fontSize: 60.0, fontWeight: FontWeight.w900);

const textStyle3 = TextStyle(color: Color(0xFFffffff), fontSize: 30.0);

class DataContainer extends StatelessWidget {
// ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  DataContainer({required this.icon, this.title});

  final IconData icon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        // ignore: prefer_const_constructors
        Icon(
          icon,
          size: 80.0,
        ),
        // ignore: prefer_const_constructors
        SizedBox(height: 15.0),
        // ignore: prefer_const_constructors
        Text(
          title!,
          // ignore: prefer_const_constructors
          style: textStyle1,
        )
      ],
    );
  }
}
