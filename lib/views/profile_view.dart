import 'package:chat_app/serializers/contact.dart';
import 'package:chat_app/view_states/home_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProfileView extends StatefulWidget {
  final Contact me;

  const ProfileView({Key key, this.me}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState(me);
}

class _ProfileViewState extends State<ProfileView> {
  final Contact me;

  TextEditingController textEditingController = TextEditingController();

  _ProfileViewState(this.me) {
    textEditingController.text = me.name;
  }

  @override
  Widget build(BuildContext context) {
    final HomeState homeState = Provider.of<HomeState>(context);
    return Scaffold(
      backgroundColor: homeState.appTheme.appBackgroundColor,
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              child: ClipRRect(
                child: Image.network(homeState.me.image),
                borderRadius: BorderRadius.circular(25),
              ),
              radius: 30,
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: textEditingController,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: homeState.appTheme.appPrimaryColor,
              textColor: homeState.appTheme.textColorLight,
              child: Text("Update"),
              onPressed: () {
                widget.me.name = textEditingController.text;
                homeState.me = widget.me;
                Toast.show("Updated", context, gravity: Toast.TOP, duration: 4);
              },
            )
          ],
        ),
      ),
    );
  }
}
