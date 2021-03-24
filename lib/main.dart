import 'package:chat_app/Helper/AuthGate.dart';
import 'package:chat_app/Helper/HelperFunction.dart';
import 'package:chat_app/Screens/ChatRoomScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunction.getUserLoggedInSP().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145c9e),
        scaffoldBackgroundColor: Color(0xff1f1f1f),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn ? ChatRoom() : Authenticate(),
    );
  }
}

// class ImBlank extends StatefulWidget {
//   @override
//   _ImBlankState createState() => _ImBlankState();
// }

// class _ImBlankState extends State<ImBlank> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
