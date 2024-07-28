import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String? name;
  String? email;
  String? uid;
  String? token;

  getdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = await pref.getString('token');
    email = await pref.getString('email');
    email = await pref.getString('password');
    uid = await pref.getString('uid');
  }

  Future<void> chekloginstatus() async {
    if (token != null) {
      Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  void initState() {
    getdata();
    var d = Duration(seconds: 2);
    Future.delayed(d, () {
      chekloginstatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'ToDo App',
          style: GoogleFonts.aBeeZee(fontSize: 20),
        ),
      ),
    );
  }
}
