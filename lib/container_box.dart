import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContainerBox extends StatelessWidget {
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  ContainerBox({required this.boxColor, this.childWidget});

  final Color boxColor;
  final Widget? childWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: childWidget,
      // ignore: prefer_const_constructors
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // ignore: prefer_const_constructors
        color: boxColor,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5.0,
              blurRadius: 7.0,
              // ignore: prefer_const_constructors
              offset: Offset(0, 3))
        ],
      ),
    );
  }
}
