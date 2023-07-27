// import 'package:flutter/foundation.dart';
// import 'package:attedance/authentication/auth_method.dart';
// import 'dart:html';

import 'package:attedance/authentication/auth_method.dart';
import 'package:attedance/screen_admin/admin_card.dart';
import 'package:attedance/screen_admin/history_attedance_admin.dart';
import 'package:attedance/widget_use/admin_tile.dart';
import 'package:attedance/widget_use/another_button.dart';
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
  // User? user;
  List<ModelData> datanew = [];
  final datas = Mocking().data;
  void loopany() {
    for (var io in datas) {
      datanew.add(ModelData(title: io[0], route: io[1], imagename: io[2]));
    }
  }

  int gridindex = 0;
  void routeadmin(BuildContext context){
    switch(gridindex){
      case 0: 
      Navigator.push(context, MaterialPageRoute(builder: (context) => AttTodayAdmin(email: widget.email,)));
      case 1:
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryAttedanceAdmin()));
      case 2:
      return ;
      case 3:
      return;
    }
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
                              onTap: (){
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
                  btnname: 'Check Attedance',
                  action: () {},
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
                                    onTap: (){
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
