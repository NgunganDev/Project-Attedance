import 'package:attedance/widget_use/non_attedance_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../format/date_format.dart';

class AttedanceToday extends StatefulWidget {
  final String usernow;
  // final String checkin;
  // final String checkout;
  const AttedanceToday({super.key, required this.usernow});

  @override
  State<AttedanceToday> createState() => _AttedanceTodayState();
}

class _AttedanceTodayState extends State<AttedanceToday> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height * 0.3,
      child: Column(
        children: [
          Container(
            width: size.width * 0.8,
            height: size.height * 0.1,
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.012, horizontal: size.width * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Good...',
                  style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.w600),
                ),
                const Icon(Icons.star_border)
              ],
            ),
          ),
          Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.usernow)
                    .collection('attedance')
                    .where('timestamp',
                        isEqualTo: Format().FormatDate(DateTime.now()))
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final datas = snapshot.data!.docs;
                    List<Map<String, dynamic>> data =
                        datas.map((e) => e.data()).toList();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: size.width * 0.8,
                            // height: size.height * 0.2,
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.012,
                                horizontal: size.width * 0.01),
                            child: data[0]['nonattedance'] == ''
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                          'Your CheckIn:',
                                          style: TextStyle(
                                              fontSize: size.height * 0.04,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          data[0]['checkin'] ??
                                              'No Attedance today',
                                        ),
                                        Container(
                                          width: size.width * 0.8,
                                          // height: size.height * 0.2,
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.height * 0.012,
                                              horizontal: size.width * 0.02),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Your CheckOut:',
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.height * 0.04,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              Text(data[0]['checkout'] == ''
                                                  ? data[0]['nonattedance']
                                                  : data[0]['checkout']),
                                              Text(data[0]['info'] ?? ''),
                                            ],
                                          ),
                                        ),
                                      ])
                                : NonAttedanceCard(
                                    nonattend: data[0]['nonattedance'],
                                    information: data[0]['info'],
                                    heights: size.height * 0.2,
                                    widths: size.width,
                                    approved: data[0]['approved'],
                                    )),
                      ],
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(
                      child: Text('No Attedance today'),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
