import 'package:flutter/material.dart';

import '../mock/model_data.dart';

class AdminTile extends StatelessWidget {
  final ModelData model;
  const AdminTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
      // width: size.width * 0.2,
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.012, horizontal: size.width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: size.width * 0.34,
              height: size.height * 0.1,
              child: Image.asset(
                model.imagename,
                fit: BoxFit.fitHeight,
              )),
          Container(
            width: size.width * 0.3,
            height: size.height * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  model.route,
                  style: TextStyle(
                      fontSize: size.height * 0.017,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
