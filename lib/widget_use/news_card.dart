import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final double widths;
  final double heights;
  final String news;
  final String title;
  final String time;
  const NewsCard(
      {super.key,
      required this.widths,
      required this.heights,
      required this.news,
      required this.time,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      width: widths,
      height: heights,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.04,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(time, style: TextStyle(
                  fontSize: size.height * 0.04,
                  fontWeight: FontWeight.w600,
                ),),
                TextButton(onPressed: (){

                }, child: Text('all news')),
              ],
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.w500
                ),),
                Text(news,style: TextStyle(
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.w400  
                ),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
