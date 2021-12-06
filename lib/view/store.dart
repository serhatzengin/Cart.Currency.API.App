import 'package:flutter/material.dart';
import 'package:sigma_basket_app/view/currency_page.dart';
import 'cart.dart';
import '../model/dish_model.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<Dish> dishes = [];
  List<Dish> cartList = [];

  @override
  void initState() {
    super.initState();
    _populateDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  const Icon(
                    Icons.shopping_cart,
                    size: 36.0,
                  ),
                  if (cartList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          cartList.length.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                if (cartList.isNotEmpty) {
                  goToCartScreen(context);
                } else if (cartList.isEmpty) {
                  showAlertDialog(context);
                }
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(flex: 3, child: _buildListView()),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CurrencyPage()),
                );
              },
              child: const Text("To Currency Page"))
        ],
      ),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        var item = dishes[index];
        return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 2.0,
            ),
            child: Card(
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        item.icon,
                        color: item.color,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(item.name),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(item.price.toString() + " TRY"),
                          GestureDetector(
                            child: (!cartList.contains(item))
                                ? const Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                            onTap: () {
                              setState(() {
                                if (!cartList.contains(item)) {
                                  cartList.add(item);
                                } else {
                                  cartList.remove(item);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  void _populateDishes() {
    var list = <Dish>[
      Dish(
        name: 'Mouse',
        icon: Icons.mouse,
        color: Colors.amber,
        price: 2,
      ),
      Dish(
        name: 'Andorid Phone',
        icon: Icons.phone_android,
        color: Colors.deepOrange,
        price: 30,
      ),
      Dish(
        name: 'I Phone',
        icon: Icons.phone_iphone_sharp,
        color: Colors.brown,
        price: 35,
      ),
      Dish(
        name: 'Keyboard',
        icon: Icons.keyboard,
        color: Colors.green,
        price: 3,
      ),
      Dish(
        name: 'Laptop Windows',
        icon: Icons.laptop_windows,
        color: Colors.purple,
        price: 45,
      ),
      Dish(
        name: 'Mac wihout macOS',
        icon: Icons.laptop_mac,
        color: Colors.blueGrey,
        price: 50,
      ),
    ];

    setState(() {
      dishes = list;
    });
  }

  void goToCartScreen(BuildContext context) async {
    List<Dish> dataFromSecondPage = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Cart(cartList),
        ));
    setState(() {
      cartList = dataFromSecondPage;
    });
  }

  showAlertDialog(BuildContext context) {
    Widget continueButton = TextButton(
      child: const Text("Close"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Empty Cart"),
      content: const Text("Please Add Product To Basket"),
      actions: [
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}