import 'package:flutter/material.dart';

class AttedanceCard extends StatelessWidget {
  final String title;
  final String checkin;
  final String checkout;
  const AttedanceCard(
      {super.key,
      required this.checkin,
      required this.checkout,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.01
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12)
      ),
      width: size.width,
      height: size.height * 0.14,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: size.height * 0.02),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'CheckIn',
                    style: TextStyle(fontSize: size.height * 0.02, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    checkin,
                    style: TextStyle(fontSize: size.height * 0.025),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'CheckOut',
                    style: TextStyle(fontSize: size.height * 0.02, fontWeight: FontWeight.w600),
                  ),
                  Text(checkout.isEmpty ? '--' : checkout,
                      style: TextStyle(fontSize: size.height * 0.025)),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
