import 'package:chat_app/serializers/contact.dart';
import 'package:chat_app/view_states/home_state.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/profile_view.dart';
import 'package:chat_app/views/shared/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget _drawer(HomeState homeState) {
    return Drawer(
      child: Container(
        color: homeState.appTheme.appBackgroundColor,
        child: Column(
          children: <Widget>[
            DrawerHeader(
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
                  Text(homeState.me.name)
                ],
              ),
            ),
            SwitchListTile(
              onChanged: (v) async {
                print(v);
                await homeState.switchAppTheme(v);
                setState(() {});
              },
              value: homeState.darkModeStatus,
              title: Text("Enable Dart Mode"),
            ),
            ListTile(
              leading: Icon(Icons.face),
              title: Text("Edit Profile"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => ProfileView(
                              me: homeState.me,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text("Logout"),
              onTap: () async {
                ConfirmAction ca = await confirm(
                    context, "Are you sure to logout from the app?");
                if (ca == ConfirmAction.ACCEPT) {
                  await homeState.logout();
                  SystemNavigator.pop(animated: true);
                } else {
                  return;
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomeState homeState = Provider.of<HomeState>(context);

    return Scaffold(
      drawer: _drawer(homeState),
      backgroundColor: homeState.appTheme.appBackgroundColor,
      appBar: AppBar(
        title: Text("iChat"),
      ),
      body: ListView.separated(
          separatorBuilder: (context, i) {
            return Divider(
              height: 1,
            );
          },
          itemCount: homeState.friends.length,
          itemBuilder: (c, i) {
            Contact contact = homeState.friends[i];
            return ListTile(
              leading: CircleAvatar(
                child: ClipRRect(
                  child: Image.network(
                    contact.image,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              title: Text(
                contact.name,
                style: TextStyle(color: homeState.appTheme.textColorDark),
              ),
              contentPadding: EdgeInsets.all(8),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => ChatView(
                              chatContact: contact,
                            )));
              },
              subtitle: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.fiber_manual_record,
                      color: contact.isOnline ? Colors.green : Colors.red,
                      size: 16,
                    ),
                    Text(
                      contact.isOnline ? "Online" : "Offline",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: homeState.appTheme.textColorLight,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
