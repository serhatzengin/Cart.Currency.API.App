import 'package:flutter/material.dart';
import 'package:sigma_basket_app/model/api_model.dart';
import 'package:sigma_basket_app/model/product_model.dart';

class DetailPage extends StatefulWidget {
  final ExchangeModel exchange;
  final Product product;
  const DetailPage({
    Key? key,
    required this.exchange,
    required this.product,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            Expanded(flex: 2, child: Text("model.rates.USD.toString()")),
            Expanded(flex: 3, child: Text("")),
            Expanded(flex: 1, child: Text("Deneme")),
          ],
        ),
      ),
    );
  }
}
