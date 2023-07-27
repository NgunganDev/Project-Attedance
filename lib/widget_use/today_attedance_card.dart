import 'package:flutter/material.dart';

class TodayAttCard extends StatelessWidget {
  final double widths;
  final double heights;
  final String name;
  final String checkin;
  final String checkout;
  const TodayAttCard(
      {super.key,
      required this.widths,
      required this.heights,
      required this.name,
      required this.checkin,
      required this.checkout});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200]
      ),
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.width * 0.02,
      ),
      width: widths,
      height: heights,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: size.width,
            child: Text(name, style: TextStyle(fontSize: size.height * 0.015),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'CheckIn',
                      style: TextStyle(
                          fontSize: size.height * 0.025,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      checkin,
                      style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'CheckOut',
                      style: TextStyle(
                          fontSize: size.height * 0.025,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      checkout,
                      style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
