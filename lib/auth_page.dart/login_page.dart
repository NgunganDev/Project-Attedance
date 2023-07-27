// import 'dart:async';

import 'package:attedance/authentication/auth_method.dart';
import 'package:attedance/routed/routed.dart';
// import 'package:attedance/screen_user/user_page.dart';
import 'package:attedance/state/state.dart';
import 'package:attedance/widget_use/sign_button.dart';
import 'package:attedance/widget_use/text_control.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController controlemail = TextEditingController();
  TextEditingController controlpassword = TextEditingController();
  final items = ['Admin', 'User'];
  String? values;
  User? usernow;
  Widget iconit(String value) {
    if (value == 'admin') {
      return const Icon(
        Icons.admin_panel_settings,
        size: 30,
      );
    } else {
      return const Icon(Icons.person_outlined, size: 30);
    }
  }

  void changeroute() async {
    await Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => Routed(email: usernow!.email!))));
    });
  }

  @override
  void initState() {
    super.initState();
      usernow = FirebaseAuth.instance.currentUser;
    if (usernow != null) {
      changeroute();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controlemail.dispose();
    controlpassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(color: Colors.grey[300]),
      width: size.width,
      height: size.height,
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.width * 0.02),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          SizedBox(
              width: size.width * 0.6,
              height: size.height * 0.3,
              child: Image.asset('images/bgatt.png')),
          Expanded(
              child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                Textcontrol(
                    controltext: controlemail,
                    hintit: 'email',
                    colorfield: Colors.white,
                    widthit: size.width * 0.9,
                    iconit: Icons.person),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Textcontrol(
                    controltext: controlpassword,
                    hintit: 'password',
                    colorfield: Colors.white,
                    widthit: size.width * 0.9,
                    iconit: Icons.password),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width * 0.9,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            ref.read(authstate.notifier).update((state) => 1);
                          },
                          child: const Text('dont have an account'))
                    ],
                  ),
                ),
                Signbutton(
                    bgbutton: Colors.black54,
                    btnname: 'SignIn',
                    action: () async{
                      await signin(controlemail.text, controlpassword.text, 'User',
                          context).then((value) => null);
                    },
                    widthit: size.width * 0.9,
                    heightit: size.height * 0.07),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
