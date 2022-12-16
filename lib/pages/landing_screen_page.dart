import 'package:eth_transactions/pages/dashboard_page.dart';
import 'package:eth_transactions/pages/login_page.dart';
import 'package:eth_transactions/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';


class LandingScreenPage extends StatefulWidget {

  @override
  State<LandingScreenPage> createState() => _LandingScreenPage();
}
class _LandingScreenPage extends State<LandingScreenPage> {

  @override
  var _session, _uri, _balance, _actprice, _actualMoney;
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'My App',
          description: 'An app for ethereum managing',
          url: 'https://ethtransactions.com',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

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
                padding: EdgeInsets.only(top: 120.0),
                child: Text(
                  'ETH TRANSFER',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Color(
                      0xffffffff)),
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
                padding: EdgeInsets.only(top: 100.0),
                child: Lottie.asset(
                  "assets/animations/127583-ethereum-purple.json",
                )
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100.0),
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: OutlinedButton(
                      onPressed: () => navigateToLogin(context),
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white, width: 1),
                          shape: const StadiumBorder()),
                      child: const Text('Access with account',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                )
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 180.0),
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () => loginUsingMetamask(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff464df6),
                          shape: const StadiumBorder()),
                      child: const Text('Register with Metamask',
                        style: TextStyle(fontSize: 18),),
                    ),
                  ),
                )
            ),
          ),
          Positioned(
              bottom: 0,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  'Author\n Alberto Rosello Martin',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(
                      0xff545454)),
                ),
              )
          ),
        ],
      ),
    );
  }

  navigateToLogin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        setState(() {
          _session = session;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage(account: _session.accounts[0].toString(),)));
      } catch (exp) {
        print(exp);
      }
    }
  }
}