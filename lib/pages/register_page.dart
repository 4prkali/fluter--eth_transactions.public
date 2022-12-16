import 'package:eth_transactions/pages/dashboard_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eth_transactions/variables/variables.dart' as variables;
import 'package:firebase_database/firebase_database.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({required this.account});
  final String account;
  @override
  State<RegisterPage> createState() => _RegisterPage(account: account);
}

class _RegisterPage extends State<RegisterPage> {
  _RegisterPage({required this.account});
  final String account;
  final myControllerUsername = TextEditingController();
  final myControllerPassword = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerUsername.dispose();
    myControllerPassword.dispose();
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
                  'Register',
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
                padding: EdgeInsets.only(top: 200.0, left: 20.0, right: 20.0),
                child: Text(
                  '${account.substring(0,4)}...${account.substring(account.length - 4, account.length)}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(
                      0xffffffff), fontSize: 20),
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
                  controller: myControllerUsername,
                  style: TextStyle(color: Colors.white),
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
                padding: EdgeInsets.only(top: 330.0, left: 40.0, right: 40.0),
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
              top: 0,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Padding(
                padding: EdgeInsets.only(top: 410.0, left: 40.0, right: 40.0),
                child: TextFormField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Confirm password',
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
                  padding: const EdgeInsets.symmetric(vertical: 650),
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () => register(context, myControllerUsername.text, myControllerPassword.text, account),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff464df6),
                          shape: const StadiumBorder()),
                      child: const Text('Register and connect',
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

setData(var account){
  getPrice();
  getBalance(account);
}

register(BuildContext context, var username, var password, var accountid) async {
  getPrice();
  getBalance(accountid);
  variables.Global.setterBalanceUSD();
  variables.Global.setterAccountID(accountid);
  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: username,
      password: password,
  ).then((value) async {
    final ref = FirebaseDatabase.instance.ref();
    ref.child('users').child(value.user!.uid).set({
      'accountid': accountid,
    });
  }).then((value) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardPage(account: accountid, name: username)));
  }).catchError((error) {
    print(error);
  });
}

