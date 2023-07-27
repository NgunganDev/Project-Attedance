// import 'package:flutter/foundation.dart';

import 'package:attedance/format/date_format.dart';
import 'package:attedance/screen_user/attedance_history.dart';
import 'package:attedance/screen_user/attedance_today.dart';
import 'package:attedance/screen_user/no_attedance.dart';
import 'package:attedance/screen_user/user_profile.dart';
// import 'package:attedance/widget_use/attedance_card.dart';
import 'package:attedance/widget_use/check_button.dart';
import 'package:attedance/widget_use/news_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
// import 'package:flutter/gestures.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

import '../authentication/auth_method.dart';

class UserPage extends StatefulWidget {
  final String usernow;
  const UserPage({super.key, required this.usernow});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String? datefirebase;
  int queue = 0;
  int indexx = 0;
  bool disabledis = false;
  int pageindex = 0;
  Map<String, dynamic>? userdays;
  late Stream<QuerySnapshot<Map<String, dynamic>>> str;

  String statuspage() {
    switch (pageindex) {
      case 0:
        return 'Today Attedance';
      case 1:
        return 'History';
      default:
        return 'Today Atedance';
    }
  }


  @override
  void initState() {
    setState(() {
      str = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.usernow)
          .collection('attedance')
          .where('timestamp', isEqualTo: Format().FormatDate(DateTime.now()))
          .snapshots();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(96, 123, 123, 123), Colors.white])),
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.01, horizontal: size.width * 0.04),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              width: size.width,
              height: size.height * 0.18,
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01, horizontal: size.width * 0.04),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.usernow)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final datas =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  datas['username'] != null
                                      ? 'Hi ${datas['username']}'
                                      : '--',
                                  style: TextStyle(
                                      fontSize: size.height * 0.03,
                                      fontWeight: FontWeight.w400),
                                ),
                                IconButton(
                                    onPressed: () {
                                      signout(context);
                                    },
                                    icon: const Icon(Icons.logout_outlined))
                              ],
                            ),
                          ),
                          Text(
                            'Get Your Attedance',
                            style: TextStyle(
                                fontSize: size.height * 0.04,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      );
                    } else {
                      return const Text('no name');
                    }
                  }),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(statuspage()),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                children: [
                  AttedanceToday(
                    usernow: widget.usernow,
                  ),
                  AttedanceHistory(
                    usernow: widget.usernow,
                  )
                ],
                onPageChanged: (value) {
                  setState(() {
                    pageindex = value;
                  });
                },
              ),
            ),
            Stack(
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: DraggableBottomSheet(
                    minExtent: size.height * 0.14,
                    useSafeArea: false,
                    curve: Curves.easeIn,
                    previewWidget: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white70,
                      ),
                      width: size.width,
                      height: size.height * 0.15,
                      child: Icon(Icons.abc),
                    ),
                    expansionExtent: 20,
                    expandedWidget: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: NewsCard(
                          widths: size.width * 0.9,
                          heights: size.height * 0.24,
                          news: 'wkwwkk',
                          time: 'Jul 12 2023',
                          title: 'PPPP'),
                    ),
                    backgroundWidget: Container(
                      width: size.width,
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    barrierColor: Colors.white,
                    barrierDismissible: true,
                    duration: const Duration(milliseconds: 300),
                    maxExtent: MediaQuery.of(context).size.height * 0.3,
                    onDragging: (pos) {},
                  ),
                ),
              ],
            ),
            Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NoAttedancePage()));
                      },
                      icon: const Icon(Icons.note_alt_rounded)),
                  Checkbutton(
                    typecheck: 'checkin',
                    disabled: disabledis,
                    namecolor: Colors.white,
                    widthit: size.width * 0.35,
                    heightit: size.height * 0.06,
                    action: () async {
                      await addcheckin(DateTime.now(), queue, '');
                      setState(() {
                        disabledis = true;
                      });
                      // print(disabledis);
                    },
                    checkname: 'Check In',
                    bgcolor: Colors.green,
                  ),
                  Checkbutton(
                    typecheck: 'checkout',
                    disabled: disabledis,
                    namecolor: Colors.white,
                    widthit: size.width * 0.35,
                    heightit: size.height * 0.06,
                    action: () {
                      updcheckout(DateTime.now(), widget.usernow);
                    },
                    checkname: 'Check Out',
                    bgcolor: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').doc(widget.usernow).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  final data = snapshot.data!.data();
                return Container(
                  width: size.width * 0.8,
                  height: size.height * 0.15,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UserProfile()));
                      },
                      child: CircleAvatar(
                        radius: size.height * 0.06,
                        backgroundImage: NetworkImage(data!['photoUrl'] != null ? data['photoUrl'] : 'https://www.aquaknect.com.au/wp-content/uploads/2014/03/blank-person-500x500.jpg'),
                      )),
                );
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              }
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              width: size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.usernow, style: TextStyle(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w600
                  ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
