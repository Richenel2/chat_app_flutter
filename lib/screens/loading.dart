import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sms/constantes/theme.dart';
import 'package:sms/databases/database.dart';
import 'package:sms/models/user_model.dart';
import 'package:sms/providers/user_provider.dart';
import 'package:sms/screens/home_page.dart';
import 'package:sms/screens/login_page.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), (() async {
      User? user = await MyDatabase.instance.getCurrentUser();
      if (user == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColor.primaryGreen,
      body: Center(child: SpinKitFadingFour(color: Colors.white)),
    );
  }
}
