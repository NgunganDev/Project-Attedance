// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalAttedance extends StatelessWidget {
  final double widths;
  final double heights;
  const TotalAttedance(
      {super.key, required this.widths, required this.heights});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(18)
      ),
      width: widths,
      height: heights,
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.width * 0.04),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: size.width * 0.3,
            height: size.height * 0.2,
            child: Image.asset('images/hibike.png', fit: BoxFit.fitWidth,)),
          Container(
            width: size.width * 0.3,
            height: size.height * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Total Attedance',
                  style: TextStyle(fontSize: size.height * 0.023, fontWeight: FontWeight.w600),
                ),
                Container(
                  width: size.width * 0.2,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    '12 Users',
                    style: TextStyle(fontSize: size.height * 0.02, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
