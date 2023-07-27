import 'package:attedance/authentication/auth_method.dart';
import 'package:attedance/format/date_format.dart';
// import 'package:attedance/widget_use/non_attedance_card.dart';
import 'package:attedance/widget_use/today_attedance_card.dart';
import 'package:attedance/widget_use/total_attedance_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'non_attedance_admin_card.dart';

class AttTodayAdmin extends StatefulWidget {
  final String email;
  const AttTodayAdmin({super.key, required this.email});

  @override
  State<AttTodayAdmin> createState() => _AttTodayAdminState();
}

class _AttTodayAdminState extends State<AttTodayAdmin> {
  List<String> todayAttedance = [];
  String dates = Format().FormatDate(DateTime.now());
  bool accepted = false;

  void fetchdatatoday() {
    final userRef = FirebaseFirestore.instance.collection('users');
    setState(() {
      todayAttedance.clear();
      // menggunakan forEach untuk loop semua data users
      userRef.get().then((docsSnap) {
        docsSnap.docs.map((docRef) {
          print(docsSnap.docs.length);
          final attRef = docRef.reference.collection('attedance');
          final timequery = attRef.where('timestamp',
              isEqualTo: Format().FormatDate(DateTime.now()));
          timequery.get().then((value) {
            value.docs.map((eData) {
              print(eData['checkin']);
              setState(() {
                todayAttedance.add(eData['checkin'] as String);
              });
            });
          });
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchdatatoday();
    print(todayAttedance.length);
  }

  int indl = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.04),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      fetchdatatoday();
                    },
                    child: Text(
                      'Attedance Today',
                      style: TextStyle(
                          fontSize: size.height * 0.04,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            TotalAttedance(
                widths: size.width * 0.8, heights: size.height * 0.2),
            SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('User Attedance')
                      .where('timestamp',
                          isEqualTo: Format().FormatDate(DateTime.now()))
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!.docs;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (_, index) {
                            final dataR = data[index];
                            print(data.length);
                            // print(dataR.id);
                            return dataR['nonattedance'] == ''
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TodayAttCard(
                                        widths: size.width,
                                        heights: size.height * 0.2,
                                        name: dataR.id,
                                        checkin: dataR['checkin'],
                                        checkout: dataR['checkout'] == ''
                                            ? 'belum terisi'
                                            : dataR['checkout']),
                                  )
                                : StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(dataR.id)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.connectionState ==
                                              ConnectionState.active) {
                                      final photo = snapshot.data!.data();
                                        return NonAttedanceCards(
                                            imgUrl: photo!['photoUrl'] == null
                                                ? "https://www.aquaknect.com.au/wp-content/uploads/2014/03/blank-person-500x500.jpg"
                                                : photo['photoUrl'],
                                            nonattend: dataR['nonattedance'],
                                            information: dataR['info'],
                                            heights: size.height * 0.22,
                                            widths: size.width,
                                            action: () async {
                                              setState(() {
                                                accepted = !accepted;
                                                // print(accepted);
                                              });
                                               await updateaccepted(accepted,
                                                  DateTime.now(), dataR.id);
                                              // print('success');
                                            },
                                            user: dataR.id,
                                            approved: dataR['approved']);
                                      } else {
                                        return Container();
                                      }
                                    });
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
