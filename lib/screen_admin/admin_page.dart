// import 'package:flutter/foundation.dart';
// import 'package:attedance/authentication/auth_method.dart';
// import 'dart:html';

import 'package:attedance/authentication/auth_method.dart';
import 'package:attedance/format/date_format.dart';
import 'package:attedance/screen_admin/admin_card.dart';
import 'package:attedance/screen_admin/history_attedance_admin.dart';
import 'package:attedance/widget_use/admin_tile.dart';
import 'package:attedance/widget_use/another_button.dart';
import 'package:attedance/widget_use/text_control.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../mock/mock_data.dart';
import '../mock/model_data.dart';
import 'attedance_today_admin.dart';

class AdminPage extends StatefulWidget {
  final String email;
  const AdminPage({super.key, required this.email});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController controlnews = TextEditingController();
  TextEditingController controlinfos = TextEditingController();
  // User? user;
  List<ModelData> datanew = [];
  final datas = Mocking().data;
  void loopany() {
    for (var io in datas) {
      datanew.add(ModelData(title: io[0], route: io[1], imagename: io[2]));
    }
  }

  int gridindex = 0;
  void routeadmin(BuildContext context) {
    switch (gridindex) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AttTodayAdmin(
                      email: widget.email,
                    )));
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HistoryAttedanceAdmin()));
      case 2:
        return;
      case 3:
        return;
    }
  }

  void showPop(Size size) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(
                vertical: size.height * 0.1, horizontal: size.width * 0.08),
            title: Text('Add Something'),
            content: Container(
              width: size.width,
              height: size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Textcontrol(
                      controltext: controlnews,
                      hintit: 'whats new today',
                      colorfield: const Color.fromARGB(255, 228, 228, 228),
                      widthit: size.width * 0.8,
                      iconit: Icons.title_sharp),
                  Textcontrol(
                      controltext: controlinfos,
                      hintit: 'add Information',
                      colorfield: Color.fromARGB(255, 225, 224, 224),
                      widthit: size.width * 0.8,
                      iconit: Icons.info_outline_rounded)
                ],
              ),
            ),
            actions: [
              SizedBox(
                width: size.width * 0.7,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnotherButton(
                        btnname: 'cancel',
                        action: () {
                          Navigator.pop(context);
                        },
                        width: size.width * 0.3,
                        height: size.height * 0.08,
                        colors: const Color.fromARGB(255, 126, 126, 126),
                        size: size,
                        radius: 18),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    AnotherButton(
                        btnname: 'add',
                        action: () async {
                          Navigator.pop(context);
                          await inputNews(controlnews.text, controlinfos.text,
                              Format().FormatDate(DateTime.now()));
                        },
                        width: size.width * 0.3,
                        height: size.height * 0.08,
                        colors: Colors.blueAccent,
                        size: size,
                        radius: 18),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    loopany();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.01,
          horizontal: size.width * 0.01,
        ),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: size.width * 0.85,
                height: size.height * 0.12,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Hi ${data['username']}',
                              style: TextStyle(
                                  fontSize: size.height * 0.045,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () {
                                signout(context);
                              },
                              child: Text(
                                'Check Users',
                                style: TextStyle(
                                    fontSize: size.height * 0.03,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.2,
                child: AdminCard(
                    widths: size.width * 0.85,
                    heights: size.height * 0.2,
                    colors: Color.fromARGB(201, 208, 208, 208)),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              AnotherButton(
                  btnname: 'Add News',
                  action: () {
                    showPop(size);
                  },
                  width: size.width * 0.85,
                  height: size.height * 0.08,
                  colors: Colors.blue,
                  size: size,
                  radius: 18),
              SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.5,
                  child: AnimationLimiter(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 180,
                                  mainAxisSpacing: 10),
                          itemCount: datanew.length,
                          itemBuilder: (_, index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 800),
                              columnCount: 2,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          gridindex = index;
                                          routeadmin(context);
                                        });
                                      },
                                      child: AdminTile(model: datanew[index])),
                                ),
                              ),
                            );
                          })))
            ],
          ),
        ),
      ),
    );
  }
}
