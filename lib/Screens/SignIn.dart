import 'package:chat_app/Helper/HelperFunction.dart';
import 'package:chat_app/Screens/ChatRoomScreen.dart';
import 'package:chat_app/Services/Auth.dart';
import 'package:chat_app/Services/Database.dart';
import 'package:chat_app/Widgets/Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = AuthMethods();
  DataBaseMathods dataBaseMathods = DataBaseMathods();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  QuerySnapshot snapShotUserInfo;

  signIn() {
    if (formKey.currentState.validate()) {
      HelperFunction.saveUserEmailSP(emailController.text);

      dataBaseMathods.getUserByEmail(emailController.text).then((value) {
        snapShotUserInfo = value;
        HelperFunction.saveUserNameSP(snapShotUserInfo.docs[0].data()['name']);
      });

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((value) {
        if (value != null) {
          HelperFunction.saveUserLoggedInSP(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)
                              ? null
                              : "Please Provide a Valid Email";
                        },
                        style: textStyle(),
                        decoration: textFieldInputDecoration('Email'),
                        controller: emailController,
                      ),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty || val.length < 6
                              ? "Please Provide Password 6+ Character"
                              : null;
                        },
                        style: textStyle(),
                        controller: passwordController,
                        decoration: textFieldInputDecoration('Password'),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Forgot Password?',
                      style: textStyle(),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(colors: [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC),
                      ]),
                    ),
                    child: Text(
                      'Sign In',
                      style: mediumTextStyle(),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Text('Sign In with Google', style: mediumTextStyle()),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have Account', style: mediumTextStyle()),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 50)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
