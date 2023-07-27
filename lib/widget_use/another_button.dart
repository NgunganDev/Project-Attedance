import 'package:flutter/material.dart';

class AnotherButton extends StatelessWidget {
  final String btnname;
  final VoidCallback action;
  final double width;
  final double height;
  final Color colors;
  final Size size;
  final double radius;

  const AnotherButton(
      {super.key,
      required this.btnname,
      required this.action,
      required this.width,
      required this.height,
      required this.colors,
      required this.size,
      required this.radius
      });

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius)
      ),
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors
        ),
          onPressed: action,
          child: Text(
            btnname,
            style: TextStyle(fontSize: size.height * 0.025),
          )),
    );
  }
}
