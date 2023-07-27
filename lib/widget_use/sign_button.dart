// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class Signbutton extends StatelessWidget {
  final String btnname;
  final double widthit;
  final double heightit;
  final VoidCallback action;
  final Color bgbutton;
  const Signbutton({super.key, required this.bgbutton,required this.btnname, required this.action, required this.widthit, required this.heightit});

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: widthit,
      height: heightit,
      child: ElevatedButton(onPressed: action, child: Text(btnname), style: ElevatedButton.styleFrom(
        backgroundColor: bgbutton
      ),),
    );
  }
}
