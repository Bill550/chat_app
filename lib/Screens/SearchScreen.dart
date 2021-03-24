import 'package:chat_app/Helper/Constants.dart';
import 'package:chat_app/Helper/HelperFunction.dart';
import 'package:chat_app/Screens/ConversationScreen.dart';
import 'package:chat_app/Services/Database.dart';
import 'package:chat_app/Widgets/Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return '$b\_$a';
  } else {
    return '$a\_$b';
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String _myName;

class _SearchScreenState extends State<SearchScreen> {
  DataBaseMathods dataBaseMathods = DataBaseMathods();
  TextEditingController searchController = TextEditingController();

  QuerySnapshot searchSnapShot;

  Widget searchList() {
    return searchSnapShot != null
        ? ListView.builder(
            itemCount: searchSnapShot.docs.length,

            //Using shrinkWrap if listView is call in column
            shrinkWrap: true,

            itemBuilder: (BuildContext context, int index) {
              return SearchTile(
                userName: searchSnapShot.docs[index].data()['name'],
                userEmail: searchSnapShot.docs[index].data()['email'],
              );
            },
          )
        : Container();
  }

  createChatRoomAndStartConversation({String userName}) {
    print("Username: " + "$userName" + "And MyName: " + "${Contstants.myName}");
    if (userName != Contstants.myName) {
      String chatRoomId = getChatRoomId(userName, Contstants.myName);

      List<String> users = [
        userName,
        Contstants.myName,
      ];

      Map<String, dynamic> chatRoomMap = {
        'users': users,
        'chatroomId': chatRoomId,
      };
      DataBaseMathods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConversationScreen(chatRoomId)));
    } else {
      print('You Can\'t Message Yourself');
      // SnackBar(content: content)
    }
  }

  initiateSearch() {
    dataBaseMathods.getUserByUserName(searchController.text).then((value) {
      setState(() {
        searchSnapShot = value;
      });
    });
  }

  @override
  void initState() {
    // getUserInfo();
    super.initState();
  }

  // getUserInfo() async {
  //   _myName = await HelperFunction.getUserNameSP();
  //   setState(() {});
  //   print("$_myName");
  // }

  Widget SearchTile({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: mediumTextStyle(),
              ),
              Text(
                userEmail,
                style: mediumTextStyle(),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndStartConversation(userName: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                'Message',
                style: mediumTextStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54ffffff),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search Username...',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0x36ffffff),
                            const Color(0x0fffffff),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Image.asset("assets/images/search_white.png"),
                    ),
                  ),
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}
