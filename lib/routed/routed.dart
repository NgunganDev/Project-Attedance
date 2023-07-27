// import 'package:attedance/auth_page.dart/login_page.dart';
// import 'package:attedance/auth_page.dart/register_page.dart';
// import 'package:attedance/authentication/auth_method.dart';
import 'package:attedance/screen_admin/admin_page.dart';
import 'package:attedance/screen_user/user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Routed extends StatefulWidget {
  final String email;
  const Routed({super.key, required this.email});

  @override
  State<Routed> createState() => _RoutedState();
}

class _RoutedState extends State<Routed> {

  // Widget routed(String type){
  //   if(type == 'User'){
  //     return UserPage(usernow: widget.email);
  //   }else{
  //     return const AdminPage();
  //   }
  // }
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    // print(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
    StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(widget.email.isEmpty ? user!.email : widget.email).snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            body: data['type'] == 'User' ? UserPage(usernow: widget.email.isEmpty ? user!.email! : widget.email) : AdminPage(email:widget.email.isEmpty ? user!.email! : widget.email ,),
          );
        }else{

        return const Center(child: CircularProgressIndicator());
        }
      }
      ),
    );

    
  }
}