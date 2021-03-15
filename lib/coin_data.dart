import 'dart:convert';

import 'package:http/http.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];


const baseURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'A5BA3EFE-3A39-4B0C-A00B-C0D0C18F4B58';

class CoinData {

  Future<double> getExchangeRate(asset, quote) async{

    Uri btcUri = Uri.parse('$baseURL/$asset/$quote?apikey=$apiKey');
    Response response = await get(btcUri);
    if(response.statusCode == 200) {
      double btcRate = jsonDecode(response.body)['rate'];
      print(btcRate);
      return btcRate;
    }
  }
}
