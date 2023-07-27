// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class Textcontrol extends StatelessWidget {
  final TextEditingController controltext;
  final String hintit;
  final Color colorfield;
  final double widthit;
  final IconData iconit;
  const Textcontrol(
      {super.key,
      required this.controltext,
      required this.hintit,
      required this.colorfield,
      required this.widthit,
      required this.iconit
      });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: widthit,
      child: TextField(
        controller: controltext,
        decoration: InputDecoration(
          prefixIcon: Icon(iconit),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 0.0, color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 0.0, color: Colors.white),
            ),
            hintText: hintit,
            filled: true,
            fillColor: colorfield,
            hintStyle: TextStyle(
              fontSize: size.height * 0.025,
            )),
      ),
    );
  }
}
