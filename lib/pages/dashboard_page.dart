import 'dart:convert';
import 'dart:ffi';
import 'package:eth_transactions/pages/landing_screen_page.dart';
import 'package:eth_transactions/pages/login_page.dart';
import 'package:eth_transactions/pages/my_wallet_page.dart';
import 'package:eth_transactions/variables/variables.dart' as variables;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import '../services/coin_data.dart';
const _API_ETHERSCAN_KEY = String.fromEnvironment('API_ETHERSCAN_KEY', defaultValue: 'SOME_DEFAULT_VALUE');
const _API_COIN_KEY = String.fromEnvironment('API_COIN_KEY', defaultValue: 'SOME_DEFAULT_VALUE');


class DashboardPage extends StatefulWidget {

  const DashboardPage({required this.account, required this.name, });
  final String account;
  final String name;
  @override
  State<DashboardPage> createState() => _DashboardPage(account: account, name: name);


}
class _DashboardPage extends State<DashboardPage> {
  _DashboardPage({required this.account, required this.name,});

  final String account;
  final String name;
  final myControllerPassword = TextEditingController();
  final myControllerUsername = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerPassword.dispose();
    myControllerUsername.dispose();
    super.dispose();
  }

  @override
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    getPrice();
    getBalance(account);
    variables.Global.setterBalanceUSD();
    getAllValues();
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    PricesScreen(),
    DashboardScreen(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1012),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0xFF030303),
        iconSize: 30,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin,
                color: Colors.white),
            label: 'Prices',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard_outlined,
              color: Colors.white,
            ),
            label: 'Dashboard',
          ),
        ],
      ),
      body: Stack(
          fit: StackFit.expand,
          children: [_pages.elementAt(_selectedIndex)], //New
      ),
    );
  }
}

class PricesScreen extends StatelessWidget {
  final myControllerAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1012),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
            child: Text(
              'USD Prices',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffffffff), fontSize: 30),
            ),
          ),
          const Positioned(
            top: 170,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 60.0, right: 20.0),
                    child: SizedBox(
                      height: 60,
                      width: 300,
                      child: Text(
                        'BTC',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 25,
                        ),
                      ),
                    )
                )
            ),
          ),
          Positioned(
            top: 170,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 120.0, right: 20.0),
                    child: SizedBox(
                      height: 60,
                      width: 300,
                      child: Text(
                        '${variables.Global.btc}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    )
                )
            ),
          ),
          const Positioned(
            top: 220,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 60.0, right: 20.0),
                    child: SizedBox(
                      height: 60,
                      width: 300,
                      child: Text(
                        'ETH',
                        style: TextStyle(
                          color: Color(0xff464df6),
                          fontSize: 25,
                        ),
                      ),
                    )
                )
            ),
          ),
          Positioned(
            top: 220,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 120.0, right: 20.0),
                    child: SizedBox(
                      height: 60,
                      width: 300,
                      child: Text(
                        '${variables.Global.eth}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    )
                )
            ),
          ),
          const Positioned(
            top: 270,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 60.0, right: 20.0),
                    child: SizedBox(
                      height: 60,
                      width: 300,
                      child: Text(
                        'LTC',
                        style: TextStyle(
                          color: Color(0xff58a91a),
                          fontSize: 25,
                        ),
                      ),
                    )
                )
            ),
          ),
          Positioned(
            top: 270,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 120.0, right: 20.0),
                    child: SizedBox(
                      height: 60,
                      width: 300,
                      child: Text(
                        '${variables.Global.ltc}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    )
                )
            ),
          ),
          const Positioned(
            top: 320,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 60.0, right: 20.0),
                    child: SizedBox(
                      height: 60,
                      width: 300,
                      child: Text(
                        'ADA',
                        style: TextStyle(
                          color: Color(0xff0c739d),
                          fontSize: 25,
                        ),
                      ),
                    )
                )
            ),
          ),
          Positioned(
            top: 320,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 120.0, right: 20.0),
                    child: SizedBox(
                      height: 60,
                      width: 300,
                      child: Text(
                        '${variables.Global.ada}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    )
                )
            ),
          ),
          const Positioned(
            top: 370,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 60.0, right: 20.0),
                    child: SizedBox(
                      height: 60,
                      width: 300,
                      child: Text(
                        'SOL',
                        style: TextStyle(
                          color: Color(0xff464df6),
                          fontSize: 25,
                        ),
                      ),
                    )
                )
            ),
          ),
          Positioned(
            top: 370,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 120.0, right: 20.0),
                    child: SizedBox(
                      height: 60,
                      width: 300,
                      child: Text(
                        '${variables.Global.sol}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    )
                )
            ),
          ),
        ],
      )
    );
  }


}

class DashboardScreen extends StatelessWidget {
  @override
  double exchangeRate = 0.0;
  dynamic exchangeRatesChartData = [ExchangeRatesData(DateTime.now(), 0.0)];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1012),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const Positioned(
          top: 60,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                'Actual Price',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xffffffff), fontSize: 18),
              ),
            ),
          ),
          Positioned(
            top: 50,
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 285.0, right: 20.0),
                  child: SizedBox(
                      height: 80,
                      width: 80,
                      child: ElevatedButton(
                        onPressed: () => logout(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F1012),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20)),
                            )),
                        child: const Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                  ),
                )
            ),
          ),
          Positioned(
            top: 90,
            child: Padding(
              padding: EdgeInsets.only(left: 50.0, right: 20.0),
              child: Text(
                '${variables.Global.getterPrice()} \$',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xffffffff), fontSize: 30),
              ),
            ),
          ),
          Positioned(
            top: 75, width: 65, height: 65,
            child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 20.0),
                child: Image.asset('assets/images/ethereum.png')),
          ),
          Positioned(
            top: 130,
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: DateTimeAxis(),
                  series: <LineSeries<ExchangeRatesData, DateTime>>[
                    LineSeries<ExchangeRatesData, DateTime>(
                      // Bind data source
                        dataSource: exchangeRatesChartData,
                        xValueMapper: (ExchangeRatesData exchangeRate, _) =>
                        exchangeRate.day,
                        yValueMapper: (ExchangeRatesData exchangeRate, _) =>
                        exchangeRate.exchangeRate),
                  ],
                ),
            )
          ),
          const Positioned(
            top: 440,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                'In Wallet',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xffffffff), fontSize: 18),
              ),
            ),
          ),
          Positioned(
            top: 465,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                '${variables.Global.getterBalance()} ETH',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xffffffff), fontSize: 30),
              ),
            ),
          ),
          Positioned(
            top: 500,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                '${variables.Global.getterBalanceUSD()} \$',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xffffffff), fontSize: 20),
              ),
            ),
          ),
          Positioned(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 620),
                  child: SizedBox(
                    height: 45,
                    width: 350,
                    child: OutlinedButton(
                      onPressed: () => goToMyWallet(context),
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff464df6), width: 1),
                          shape: const StadiumBorder()),
                      child: const Text('My Wallet',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  logout(BuildContext context) {
    FirebaseAuth.instance.signOut().whenComplete(() {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LandingScreenPage()),
              (Route<dynamic> route) => false);
    });
  }
}
class TransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: const <Widget>[
        ListTile( title: Text('List 1')),
        ListTile( title: Text('List 2')),
        ListTile( title: Text('List 3')),
      ],
    );
  }
}

goToMyWallet(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyWalletPage()));
}
goToSend() {

}
Future<void> getBalance(String accountID) async {
  var url = Uri.https('api-goerli.etherscan.io', '/api', {
    'module': 'account',
    'action': 'balance',
    'address': variables.Global.AccountID,
    'tag': 'latest',
    'apikey': _API_ETHERSCAN_KEY
  });
  double initialBalance;
  http.Response response = await http.get(url);
  final Map<String, dynamic> responseData = json.decode(response.body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    initialBalance = (double.parse(responseData['result']) * 0.000000000000000001);
    variables.Global.setterBalance(initialBalance.toString());
  } else {
    throw Exception('Failed to load balance');
  }
}

Future<void> getPrice() async {
  var url = Uri.https('api.etherscan.io', '/api', {
    'module': 'stats',
    'action': 'ethprice',
    'apikey': _API_ETHERSCAN_KEY
  });
  double initialPriceUSD;
  http.Response response = await http.get(url);
  final Map<String, dynamic> responseData = json.decode(response.body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    final Map<String, dynamic> priceData = responseData['result'];
    initialPriceUSD = (double.parse(priceData['ethusd']));
    variables.Global.setterPrice(initialPriceUSD.toString());
  } else {
    throw Exception('Failed to load price');
  }
}


Future<void> getAllValues() async {
  var urlBTC = Uri.https('api.coingecko.com', '/api/v3/simple/price', {
    'ids': 'bitcoin',
    'vs_currencies':'usd'
  });

  var urlETH = Uri.https('api.coingecko.com', '/api/v3/simple/price', {
    'ids': 'ethereum',
    'vs_currencies':'usd'
  });

  var urlLTC = Uri.https('api.coingecko.com', '/api/v3/simple/price', {
    'ids': 'litecoin',
    'vs_currencies':'usd'
  });

  var urlADA = Uri.https('api.coingecko.com', '/api/v3/simple/price', {
    'ids': 'cardano',
    'vs_currencies':'usd'
  });

  var urlSOL = Uri.https('api.coingecko.com', '/api/v3/simple/price', {
    'ids': 'solana',
    'vs_currencies':'usd'
  });

  http.Response responsebtc = await http.get(urlBTC);
  http.Response responseeth = await http.get(urlETH);
  http.Response responseltc = await http.get(urlLTC);
  http.Response responseada = await http.get(urlADA);
  http.Response responsesol = await http.get(urlSOL);

  final responseData = json.decode(responsebtc.body);
  final responseData2 = json.decode(responseeth.body);
  final responseData3 = json.decode(responseltc.body);
  final responseData4 = json.decode(responseada.body);
  final responseData5 = json.decode(responsesol.body);

  if (responsebtc.statusCode == 200 || responsebtc.statusCode == 201) {
    variables.Global.btc = responseData['bitcoin']['usd'].toString();
  } else {
    throw Exception('Failed to load price');
  }
  if (responseeth.statusCode == 200 || responseeth.statusCode == 201) {
    variables.Global.eth = responseData2['ethereum']['usd'].toString();
  } else {
    throw Exception('Failed to load price');
  }
  if (responseltc.statusCode == 200 || responseltc.statusCode == 201) {
    variables.Global.ltc = responseData3['litecoin']['usd'].toString();
  } else {
    throw Exception('Failed to load price');
  }
  if (responseada.statusCode == 200 || responseada.statusCode == 201) {
    variables.Global.ada = responseData4['cardano']['usd'].toString();
  } else {
    throw Exception('Failed to load price');
  }
  if (responsesol.statusCode == 200 || responsesol.statusCode == 201) {
    variables.Global.sol = responseData5['solana']['usd'].toString();
  } else {
    throw Exception('Failed to load price');
  }
}