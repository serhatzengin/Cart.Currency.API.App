import 'package:flutter/material.dart';

import '../model/dish_model.dart';

class Cart extends StatefulWidget {
  final List<Dish> cart;

  const Cart(this.cart);

  @override
  _CartState createState() => _CartState(cart);
}

class _CartState extends State<Cart> {
  List<Dish> cart;

  _CartState(this.cart);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context, cart);
            });
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
          ),
        ),
        title: const Text('Cart'),
      ),
      body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            var item = cart[index];
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
                          cart.remove(item);
                        });
                      }),
                ),
              ),
            );
          }),
    );
  }
}
