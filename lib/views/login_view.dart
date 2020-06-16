import 'package:chat_app/view_states/home_state.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final HomeState homeState = Provider.of<HomeState>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                "Chat App",
                style: TextStyle(fontSize: 22, color: Colors.blue),
              ),
              Expanded(
                child: Center(
                  child: Image.asset("assets/images/1.jpg"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("Login"),
                    onPressed: () async {
                      ProgressDialog pr =
                          ProgressDialog(context, isDismissible: false);
                      pr.show();
                      await homeState.loadFriends();
                      pr.hide();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (c) => HomeView()));
                    },
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("Sign Up"),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
