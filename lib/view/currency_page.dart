import 'package:flutter/material.dart';
import 'package:sigma_basket_app/model/api_model.dart';
import 'package:sigma_basket_app/services/services.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  @override
  Widget build(BuildContext context) {
    var _service = Currency().sendAndGet();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _service,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              ExchangeModel model = snapshot.data as ExchangeModel;
              var result = model.rates.USD * model.rates.EUR;
              return Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('EURO: ' + model.rates.EUR.toString()),
                          Text('USD: ' + model.rates.USD.toString() + " EURO"),
                          Text('TRY: ' + model.rates.TRY.toString() + " EURO"),
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text("Refresh"))
                  ],
                ),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
