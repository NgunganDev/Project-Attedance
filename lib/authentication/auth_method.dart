// /import 'dart:html';

import 'package:attedance/format/date_format.dart';
import 'package:attedance/main_page.dart';
import 'package:attedance/routed/routed.dart';
import 'package:attedance/screen_admin/admin_page.dart';
import 'package:attedance/screen_user/user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Method {

}
Future<void> signup(String username, String email, String password,
    String created, WidgetRef ref, String type, BuildContext context) async {
  // String usernows = FirebaseAuth.instance.currentUser!.email!;
  await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((value) {
    if (type == 'User') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => UserPage(usernow: email)));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AdminPage(
                    email: email,
                  )));
    }
  });
  await FirebaseFirestore.instance.collection('users').doc(email).set({
    'username': username,
    'email': email,
    'createdat': created,
    'type': type,
  });
}

Future<void> signin(
    String emails, String password, String type, BuildContext context) async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: emails, password: password)
      .then((value) => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Routed(email: emails))));
}

Future<void> addcheckin(DateTime date, int queue, String nonattedance) async {
  String usernows = FirebaseAuth.instance.currentUser!.email!;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(usernows)
      .collection('attedance')
      .add({
    'timestamp': Format().FormatDate(date),
    'checkin': Format().FormatTime(date),
    'checkout': '',
    'queue': queue,
    'nonattedance': nonattedance,
  });

  await FirebaseFirestore.instance
      .collection('User Attedance')
      .doc(usernows)
      .set({
    'checkin': Format().FormatTime(date),
    'timestamp': Format().FormatDate(date),
    'checkout': '',
    'nonattedance': nonattedance,
  });
  // print(usernows);
}

Future<void> updcheckout(DateTime date, String username) async {
  String usernows = FirebaseAuth.instance.currentUser!.email!;
  CollectionReference datacos = FirebaseFirestore.instance
      .collection('users')
      .doc(usernows)
      .collection('attedance');
  QuerySnapshot dataup = await datacos
      .where('timestamp', isEqualTo: Format().FormatDate(date))
      .get();
  for (var i in dataup.docs) {
    DocumentReference up = datacos.doc(i.id);
    await up.update({
      'checkout': Format().FormatTime(date),
    });
  }
  await FirebaseFirestore.instance
      .collection('User Attedance')
      .doc(username)
      .update({
    'checkout': Format().FormatTime(date),
  });
}

Future<void> signout(BuildContext context) async {
  await FirebaseAuth.instance.signOut().then((value) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage())));
}

Future<void> nonattedance(String queue, DateTime date, String typenon,
    String info, BuildContext context) async {
  String usernows = FirebaseAuth.instance.currentUser!.email!;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(usernows)
      .collection('attedance')
      .add({
    'timestamp': Format().FormatDate(date),
    'checkin': Format().FormatTime(date),
    'checkout': '',
    'queue': queue,
    'nonattedance': typenon,
    'info': info,
    'approved': false,
  }).then((value) => Navigator.pop(context));

  await FirebaseFirestore.instance
      .collection('User Attedance')
      .doc(usernows)
      .set({
    'nonattedance': typenon,
    'info': info,
    'approved': false,
    'timestamp': Format().FormatDate(date),
    'checkin': Format().FormatTime(date),
  }).then((value) {
    print('success update in User Attedance');
  });
}

Future<void> updateaccepted(
    bool condition, DateTime date, String username) async {
  CollectionReference datacos = FirebaseFirestore.instance
      .collection('users')
      .doc(username)
      .collection('attedance');
  QuerySnapshot dataup = await datacos
      .where('timestamp', isEqualTo: Format().FormatDate(date))
      .get();
  for (var i in dataup.docs) {
    DocumentReference up = datacos.doc(i.id);
    await up.update({
      'approved': condition,
    });
  }
// ---------------------------------------------------------------
  CollectionReference datacosl =
      FirebaseFirestore.instance.collection('User Attedance');
  await datacosl.doc(username).update({
    "approved": condition,
  }).then((value) {
    print('apakah sukses terpaksa menggunakan fungsi ini di feature 2');
  });
}

Future<void> deleteItem(String username, String id) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(username)
      .collection('attedance')
      .doc(id)
      .delete();
}

Future<void> updatePhoto(String username, String url) async {
  CollectionReference refcol = FirebaseFirestore.instance.collection('users');
  await refcol.doc(username).update({
    'photoUrl': url,
  }).then((value) {
    print('success add photosiro');
  });
}



Future<void> inputNews(String title, String text, String path) async {
  CollectionReference refNews = FirebaseFirestore.instance.collection('News');
  await refNews.doc(path).update({
    'title': title,
    'information': text,
    'createdat': Format().FormatDate(DateTime.now())
  }).then((value) {
    print('news added');
  });
}
