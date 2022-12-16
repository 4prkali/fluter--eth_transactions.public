import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:eth_transactions/variables/variables.dart' as variables;
import 'package:flutter/services.dart';



class MyWalletPage extends StatefulWidget {
  @override
  State<MyWalletPage> createState() => _MyWalletPage();
}
class _MyWalletPage extends State<MyWalletPage> {
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
              top: 100,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  'My Wallet',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(
                      0xffffffff), fontSize: 30),
                ),
              ),
          ),
          Positioned(
            top: 50,
            child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: IconButton(
                      onPressed: () => goBack(context),
                      icon: Icon(Icons.arrow_back_rounded),
                      color: const Color(0xff464df6),
                      iconSize: 50,
                      padding: EdgeInsets.zero,
                    ),
                  ),
            ),
          ),
          Positioned(
            top: 160,
            child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 45.0, right: 45.0),
                  child: QrImage(
                    data: variables.Global.AccountID,
                    version: QrVersions.auto,
                    foregroundColor: Colors.white,
                    size: 300.0,
                  ),
                )
            ),
          ),
          Positioned(
            top: 500,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                '${variables.Global.AccountID.substring(0,4)}...${variables.Global.AccountID.substring(variables.Global.AccountID.length-4)}',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(
                    0xffffffff), fontSize: 30),
              ),
            ),
          ),
          Positioned(
            top: 570,
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 155.0, right: 20.0),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () => copyToClipboard(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff464df6),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20)),
                          )),
                      child: Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ),
                )
            ),
          ),
          Positioned(
            top: 665,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                'Copy',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(
                    0xffffffff), fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

goBack(BuildContext context) {
    Navigator.pop(context);
  }

  copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: variables.Global.AccountID));
  }

void _shareContent() {
print("hello");
}