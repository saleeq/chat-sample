import 'dart:io';

import 'package:chat_app/serializers/chat_message.dart';
import 'package:chat_app/serializers/contact.dart';
import 'package:chat_app/view_states/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  final Contact chatContact;

  const ChatView({Key key, this.chatContact}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController chatMessageController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final HomeState homeState = Provider.of<HomeState>(context);
    List<ChatMessage> messages = homeState.loadMessages(widget.chatContact.id);
    return Scaffold(
      backgroundColor: homeState.appTheme.appBackgroundColor,
      appBar: AppBar(
        title: Text(widget.chatContact.name),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 8),
                color: homeState.appTheme.appBackgroundColor,
                child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (c, i) {
                      if (messages[i].fromId == homeState.me.id) {
                        if (messages[i].isImage) {
                          return Container(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: homeState
                                      .appTheme.messageBackgroundColor),
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(top: 8, right: 8),
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: Image.file(File(messages[i].image)),
                                  ),
                                  Text(
                                    messages[i].message,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            homeState.appTheme.textColorDark),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          if (messages[i].isImage) {
                            return Container(
                              alignment: Alignment.centerRight,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: homeState
                                        .appTheme.messageBackgroundColor),
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(top: 8, right: 8),
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      child:
                                          Image.file(File(messages[i].image)),
                                    ),
                                    Text(
                                      messages[i].message,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              homeState.appTheme.textColorDark),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              alignment: Alignment.centerRight,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: homeState
                                        .appTheme.messageBackgroundColor),
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(top: 8, right: 8),
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Text(
                                  messages[i].message,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: homeState.appTheme.textColorDark),
                                ),
                              ),
                            );
                          }
                        }
                      } else {
                        return Container(
                          child: Container(
                            color: homeState.appTheme.messageBackgroundColor,
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Text(
                              messages[i].message,
                              style: TextStyle(
                                  color: homeState.appTheme.textColorDark),
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: homeState.appTheme.textColorLight))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: TextField(
                          controller: chatMessageController,
                          autofocus: false,
                          style: TextStyle(
                              color: homeState.appTheme.textColorDark),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  IconButton(
                    color: Colors.blue,
                    onPressed: () async {
                      final pickedFile =
                          await picker.getImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        homeState.sendMessage(ChatMessage(
                          isImage: true,
                          image: pickedFile.path,
                          message: chatMessageController.text,
                          date: DateTime.now().toString(),
                          fromId: homeState.me.id,
                          toId: widget.chatContact.id,
                        ));
                        setState(() {
                          chatMessageController.text = "";
                          _scrollController.animateTo(
                            0.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        });
                      }
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      //color: Colors.white,
                    ),
                  ),
                  IconButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (chatMessageController.text == "") {
                        return;
                      }
                      homeState.sendMessage(ChatMessage(
                        isImage: false,
                        message: chatMessageController.text,
                        date: DateTime.now().toString(),
                        fromId: homeState.me.id,
                        toId: widget.chatContact.id,
                      ));
                      setState(() {
                        chatMessageController.text = "";
                        _scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                      });
                    },
                    icon: Icon(
                      Icons.send,
                      //color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
