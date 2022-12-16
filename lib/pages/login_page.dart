import 'dart:async';
import 'dart:convert';

import 'package:eth_transactions/pages/dashboard_page.dart';
import 'package:eth_transactions/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:eth_transactions/variables/variables.dart' as variables;



class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}
class _LoginPage extends State<LoginPage> {
  final myControllerPassword = TextEditingController();
  final myControllerUsername = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerPassword.dispose();
    myControllerUsername.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1012),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
              top: 0,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: const Padding(
                padding: EdgeInsets.only(top: 150.0, left: 20.0, right: 20.0),
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(
                      0xffffffff), fontSize: 30),
                ),
              )
          ),
          Positioned(
              top: 0,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Padding(
                padding: EdgeInsets.only(top: 250.0, left: 40.0, right: 40.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: myControllerUsername,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color(0xffffffff)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffffffff)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffffffff)),
                    ),
                  ),
                ),
              )
          ),
          Positioned(
              top: 0,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Padding(
                padding: EdgeInsets.only(top: 360.0, left: 40.0, right: 40.0),
                child: TextFormField(
                  controller: myControllerPassword,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0xffffffff)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffffffff)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffffffff)),
                    ),
                  ),
                ),
              )
          ),
          Positioned(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 600),
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () => login(myControllerUsername.text, myControllerPassword.text, context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff464df6),
                          shape: const StadiumBorder()),
                      child: const Text('Connect',
                        style: TextStyle(fontSize: 18),),
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}

login(var username, var password, BuildContext context) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password
    ).then((value) async {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('users/${value.user?.uid}/accountid').get();
      if (snapshot.exists) {
        final accountid = snapshot.value.toString();
        variables.Global.AccountID = accountid;
      } else {
        print('No data available.');
      }
    }).then((value)  {
      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardPage(account: variables.Global.AccountID, name: username)));
      });
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}