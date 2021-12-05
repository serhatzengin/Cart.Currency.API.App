import 'package:flutter/material.dart';
import 'model/dish_model.dart';

class Cart extends StatefulWidget {
  final List<Dish> _cart;

  const Cart(
    Key? key,
    this._cart,
  ) : super(key: key);

  @override
  _CartState createState() => _CartState(_cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);

  final List<Dish> _cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            ElevatedButton(onPressed: () {}, child: const Text("Geri Gel")),
        title: const Text('Cart'),
      ),
      body: ListView.builder(
          itemCount: _cart.length,
          itemBuilder: (context, index) {
            var item = _cart[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  leading: Icon(
                    item.icon,
                    color: item.color,
                  ),
                  title: Text(item.name),
                  trailing: GestureDetector(
                      child: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onTap: () {
                        setState(() {
                          _cart.remove(item);
                        });
                      }),
                ),
              ),
            );
          }),
    );
  }
}
