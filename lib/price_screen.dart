import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
      value: selectedValue,
      items: [
        ...currenciesList.map((e) => DropdownMenuItem(
              child: Text(e),
              value: e,
            ))
      ],
      onChanged: (value) {
        setState(() {
          selectedValue = value;
          fetchCoinData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (index) {
        print(index);
        setState(() {
          selectedValue = currenciesList[index];
          fetchCoinData();
        });
      },
      children: [
        ...currenciesList.map((e) => Text(e)),
      ],
    );
  }

  String selectedValue = 'USD';
  CoinData coinData = CoinData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCoinData();
  }

  Map<String, double> btsRate = {};
  void fetchCoinData() async {
    Map<String, double> list = {};
    for (int i = 0; i < cryptoList.length; i++) {
      double value =
          await coinData.getExchangeRate(cryptoList[i], selectedValue);
      list.addAll({cryptoList[i]: value});
    }
    setState(() {
      btsRate = list;
      print(list);
    });
  }
  List<Widget> getConversionCards() {
    List<Widget> cards = [
      ...cryptoList.map((e) => Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $e = ${btsRate[e]?.toStringAsFixed(2) ?? '?'} $selectedValue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
      )
    ];
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    ;
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: getConversionCards(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

/*


 */
