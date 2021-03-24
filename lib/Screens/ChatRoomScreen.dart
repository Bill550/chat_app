import 'dart:html';

import 'package:chat_app/Helper/AuthGate.dart';
import 'package:chat_app/Helper/Constants.dart';
import 'package:chat_app/Helper/HelperFunction.dart';
import 'package:chat_app/Screens/ConversationScreen.dart';
import 'package:chat_app/Screens/SearchScreen.dart';
import 'package:chat_app/Services/Auth.dart';
import 'package:chat_app/Services/Database.dart';
import 'package:chat_app/Widgets/Widget.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom({Key key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  DataBaseMathods dataBaseMathods = DataBaseMathods();
  AuthMethods authMethods = AuthMethods();

  Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      // initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChatRoomsTile(
                      snapshot.data.documents[index].data['chatroomId']
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Contstants.myName, 'replace'),
                      snapshot.data.documents[index].data['chatroomId']);
                },
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Contstants.myName = await HelperFunction.getUserNameSP();
    dataBaseMathods.getChatRooms(Contstants.myName).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('"assets/images/logo.png'),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String otherUserName;
  final String chatRoomID;
  ChatRoomsTile(this.otherUserName, this.chatRoomID);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoomID)));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(40)),
              child: Text(
                '${otherUserName.substring(0, 1).toUpperCase()}',
                style: mediumTextStyle(),
              ),
            ),
            SizedBox(width: 8),
            Text(
              otherUserName,
              style: mediumTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
