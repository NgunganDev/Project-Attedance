// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:attedance/authentication/auth_method.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import '../authentication/auth_method.dart';

class NonAttedanceCards extends StatelessWidget {
  final String user;
  final double widths;
  final double heights;
  final String nonattend;
  final String information;
  final bool approved;
  final VoidCallback action;
  final String imgUrl;
  const NonAttedanceCards(
      {super.key,
      required this.user,
      required this.nonattend,
      required this.information,
      required this.heights,
      required this.widths,
      required this.approved,
      required this.action,
      required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: widths,
      height: heights,
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.height * 0.01,
      ),
      child: Column(
        children: [
          Container(
            child: Text(
              user,
              style: TextStyle(
                  fontSize: size.height * 0.02, fontWeight: FontWeight.w400),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(imgUrl),
                    ),
                    SizedBox(
                      height: size.height * 0.042,
                    ),
                    Text(
                      'User',
                      style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Container(
                width: size.width * 0.4,
                height: size.height * 0.16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nonattend,
                      style: TextStyle(
                          fontSize: size.height * 0.05,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      information,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InkWell(
                      onTap: action,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.01,
                            horizontal: size.height * 0.012),
                        decoration: BoxDecoration(
                            color: approved ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(15)),
                        width: size.width * 0.3,
                        height: size.height * 0.05,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            approved
                                ? const Icon(
                                    Icons.check_circle_outlined,
                                    color: Colors.white,
                                  )
                                : const Icon(Icons.do_not_touch),
                            approved
                                ? Text(
                                    'Accepted',
                                    style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Declined',
                                    style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.3,
                child: Lottie.asset(
                    nonattend == 'Sakit'
                        ? 'lottie/sick_lottie.json'
                        : 'lottie/cycle_lottie.json',
                    fit: BoxFit.fitHeight),
              )
            ],
          ),
        ],
      ),
    );
  }
}
