import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '14EA97E6-F37D-4A3F-AF90-439B5DBC69DE';
const coinAPIMapURL = 'https://rest.coinapi.io/v1/ohlcv/BITSTAMP_SPOT';

const Map<String, String> currenciesMap = {
  'USD': 'US Dollar',
  'EUR': 'Euro',
  'GBP': 'British Pound',

};

const Map<String, String> cryptoMap = {
  'BTC': 'Bitcoin',
  'ETH': 'Ethereum',
}

class CoinData {
  Future<List<ExchangeRatesData>> getExchangeRates(
      {required String currency, required String crypto}) async {
    List<ExchangeRatesData> exchangeRatesList = [];

    var uri = Uri.parse(
        '${coinAPIMapURL}_${crypto}_$currency/latest?period_id=5DAY&limit=36&apikey=$apiKey');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      String data = response.body;
      List<dynamic> decodedData = jsonDecode(data);

      for (dynamic item in decodedData) {
        exchangeRatesList.add(ExchangeRatesData(
            DateTime.parse(item['time_close']), item['price_close']));
      }
      return exchangeRatesList;
    } else {
      return [ExchangeRatesData(DateTime.now(), 0.0)];
    }
  }
}

class ExchangeRatesData {
  ExchangeRatesData(this.day, this.exchangeRate);
  final DateTime day;
  final double exchangeRate;
}