import 'package:attedance/auth_page.dart/login_page.dart';
import 'package:attedance/auth_page.dart/register_page.dart';
import 'package:attedance/state/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {

  Widget rendered(int state){
    switch(state){
      case 0:
      return const LoginPage();
      case 1:
      return const SignupPage();
      default:
      return const LoginPage();

    }
  }

  User? user;
  @override
  void initState() {
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final stateit = ref.watch(authstate);
    return Scaffold(
      body: rendered(stateit),
    );
  }
}