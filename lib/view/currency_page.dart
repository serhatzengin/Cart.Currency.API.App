import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sigma_basket_app/model/api_model.dart';
import 'package:sigma_basket_app/services/services.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  @override
  Widget build(BuildContext context) {
    var _service = HomeService(
        Dio(BaseOptions(baseUrl: 'http://api.exchangeratesapi.io/v1')));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Page"),
      ),
      body: Column(
        children: [
          Expanded(child: currencyApi(_service)),
        ],
      ),
    );
  }

  FutureBuilder<ExchangeModel> currencyApi(HomeService _service) {
    return FutureBuilder(
      future: _service.fetchUsers(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.data != null) {
              ExchangeModel testmodel = snapshot.data as ExchangeModel;
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('EURO: ' + testmodel.rates.EUR.toString()),
                            Text('USD: ' + testmodel.rates.USD.toString()),
                            Text('TRY: ' + testmodel.rates.TRY.toString()),
                          ],
                        ),
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
            }
            return const Center(child: CircularProgressIndicator());
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
