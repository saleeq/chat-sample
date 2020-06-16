import 'dart:async';

import 'package:chat_app/view_states/home_state.dart';
import 'package:chat_app/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  startTimer() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => LoginView()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to Chat App",
          style: TextStyle(fontSize: 22, color: Colors.redAccent),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    HomeState homeState = Provider.of<HomeState>(context);
    homeState.loadTheme();
  }
}
