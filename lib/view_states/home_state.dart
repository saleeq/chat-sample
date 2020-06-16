import 'package:chat_app/app_theme/theme.dart';
import 'package:chat_app/serializers/chat_message.dart';
import 'package:chat_app/serializers/contact.dart';
import 'package:chat_app/view_states/view_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/***
 * Home State is the global state for the entire app
 */
class HomeState extends ViewState {
  Contact _me;
  List<Contact> friends = List();
  List<ChatMessage> messages = List();

  Contact get me => _me;

  set me(Contact value) {
    _me = value;
    setState();
  }

  //Dynamic Themeing
  AppTheme appTheme;
  bool darkModeStatus;

  Future switchAppTheme(bool isDarkMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isDarkTheme", isDarkMode);

    if (isDarkMode) {
      appTheme = AppDarkTheme();
    } else {
      appTheme = AppLightTheme();
    }
    darkModeStatus = isDarkMode;
    notifyListeners();
  }

  void loadTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("isDarkTheme")) {
      if (sharedPreferences.getBool("isDarkTheme")) {
        appTheme = AppDarkTheme();
        darkModeStatus = true;
      } else {
        appTheme = AppLightTheme();
        darkModeStatus = false;
      }
    } else {
      appTheme = AppLightTheme();
      darkModeStatus = false;
    }
  }

  // Manage chat messages
  List<ChatMessage> loadMessages(int toId) {
    return messages
        .where((element) => (element.fromId == me.id && element.toId == toId))
        .toList();
  }

  void sendMessage(ChatMessage chatMessage) async {
    messages.insert(0, chatMessage);
    setState();
  }

  // Manage Contacts

  Future loadFriends() async {
    //Fake load for api
    await Future.delayed(Duration(seconds: 3), () {
      friends.clear();
      friends.add(Contact(
          id: 1,
          image:
              "https://www.kindpng.com/picc/m/136-1369892_avatar-people-person-business-user-man-character-avatar.png",
          isOnline: true,
          name: "Ahana"));
      friends.add(Contact(
          id: 2,
          image:
              "https://www.kindpng.com/picc/m/136-1369892_avatar-people-person-business-user-man-character-avatar.png",
          isOnline: true,
          name: "James"));
      friends.add(Contact(
          id: 3,
          image:
              "https://www.kindpng.com/picc/m/136-1369892_avatar-people-person-business-user-man-character-avatar.png",
          isOnline: false,
          name: "Bill Gates"));

      //Load Me;
      _me = Contact(
          id: 4,
          image:
              "https://www.kindpng.com/picc/m/136-1369892_avatar-people-person-business-user-man-character-avatar.png",
          isOnline: true,
          name: "Saleeq Mohammed");
    });
  }

  //logout
  Future<bool> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.clear();
  }
}
