import 'package:attedance/authentication/auth_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../widget_use/attedance_card.dart';

class AttedanceHistory extends StatefulWidget {
  final String usernow;
  const AttedanceHistory({super.key, required this.usernow});

  @override
  State<AttedanceHistory> createState() => _AttedanceHistoryState();
}

class _AttedanceHistoryState extends State<AttedanceHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      height: size.height * 0.3,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.usernow)
              .collection('attedance')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final datas = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: datas.length,
                  itemBuilder: (_, index) {
                   return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          curve: Curves.easeIn,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.01,
                            ),
                            child: InkWell(
                              onDoubleTap: (){
                                deleteItem(widget.usernow, datas[index].id);
                              },
                              child: AttedanceCard(
                                  checkin: datas[index]['checkin'] == ''
                                      ? datas[index]['info']
                                      : datas[index]['checkin'],
                                  checkout: datas[index]['checkout'] == ''
                                      ? datas[index]['nonattedance']
                                      : datas[index]['checkout'],
                                  title: datas[index]['timestamp'] ?? '--'),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
