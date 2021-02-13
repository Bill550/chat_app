import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset("assets/images/logo.png", height: 50),
  );
}

InputDecoration textFieldInputDecoration(String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    hintStyle: TextStyle(color: Colors.white54),
  );
}

TextStyle textStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}


TextStyle mediumTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
  );
}
