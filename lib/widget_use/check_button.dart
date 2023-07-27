// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Checkbutton extends StatelessWidget {
  final double widthit;
  final double heightit;
  final VoidCallback action;
  final String checkname;
  final Color namecolor;
  final Color bgcolor;
  final bool disabled;
  final String typecheck;
  const Checkbutton(
      {super.key,
      required this.namecolor,
      required this.widthit,
      required this.heightit,
      required this.action,
      required this.bgcolor,
      required this.typecheck,
      required this.disabled,
      required this.checkname});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthit,
      height: heightit,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: bgcolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: disabled && typecheck == 'checkin' ? null : action,
          child: Text(
            checkname,
            style: TextStyle(color: namecolor),
          )),
    );
  }
}
