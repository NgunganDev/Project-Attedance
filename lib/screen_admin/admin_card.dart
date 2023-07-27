import 'package:flutter/material.dart';

class AdminCard extends StatelessWidget {
  final double widths;
  final double heights;
  final Color colors;
  const AdminCard(
      {super.key,
      required this.widths,
      required this.heights,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
         padding: EdgeInsets.symmetric(
          vertical: size.height * 0.01,
          horizontal: size.width * 0.02,
        ),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(18)
      ),
      width: widths,
      height: heights,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.6,
            height: size.height * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width * 0.5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: size.height * 0.06,
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bu Boss', style: TextStyle(fontSize: size.height * 0.025, fontWeight: FontWeight.w600),),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          Text('Admin',style: TextStyle(fontSize: size.height * 0.02, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: size.width * 0.2,
            height: size.height * 0.12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.006,
                ),
                Text('Personal', style: TextStyle(fontSize: size.height * 0.02, fontWeight: FontWeight.w500)),
                Image.asset('images/arrow_page.png', fit: BoxFit.contain,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
