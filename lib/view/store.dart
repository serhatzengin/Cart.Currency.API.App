import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sigma_basket_app/model/api_model.dart';
import 'package:sigma_basket_app/services/services.dart';
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
    var _service = HomeService(
        Dio(BaseOptions(baseUrl: 'http://api.exchangeratesapi.io/v1')));
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
                  goToSecondScreen(context);
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
          Expanded(flex: 3, child: _buildGridView()),
          Expanded(child: currencyApi(_service)),
          TextButton(
              onPressed: () {
                setState(() {
                  int a = 5;
                  debugPrint(cross(a).toString());
                });
              },
              child: const Text("Push"))
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
                child: SizedBox(
                  height: 100,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('TRY: ' + testmodel.rates.TRY.toString()),
                        Text('AED: ' + testmodel.rates.AED.toString()),
                        Text('USD: ' + testmodel.rates.USD.toString())
                      ],
                    ),
                  ),
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
            elevation: 4.0,
            child: ListTile(
              leading: Icon(
                item.icon,
                color: item.color,
              ),
              title: Text(item.name),
              trailing: GestureDetector(
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
            ),
          ),
        );
      },
    );
  }

  GridView _buildGridView() {
    return GridView.builder(
        padding: const EdgeInsets.all(4.0),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          var item = dishes[index];
          return Card(
              elevation: 4.0,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        item.icon,
                        color: (cartList.contains(item))
                            ? Colors.grey
                            : item.color,
                        size: 100.0,
                      ),
                      Text(
                        item.name,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
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
                    ),
                  ),
                ],
              ));
        });
  }

  void _populateDishes() {
    var list = <Dish>[
      Dish(
        name: 'Chicken Zinger',
        icon: Icons.fastfood,
        color: Colors.amber,
        price: 25,
      ),
      // Dish(
      //   name: 'Chicken Zinger without chicken',
      //   icon: Icons.print,
      //   color: Colors.deepOrange,
      // ),
      // Dish(
      //   name: 'Rice',
      //   icon: Icons.child_care,
      //   color: Colors.brown,
      // ),
      // Dish(
      //   name: 'Beef burger without beef',
      //   icon: Icons.whatshot,
      //   color: Colors.green,
      // ),
      // Dish(
      //   name: 'Laptop without OS',
      //   icon: Icons.laptop,
      //   color: Colors.purple,
      // ),
      // Dish(
      //   name: 'Mac wihout macOS',
      //   icon: Icons.laptop_mac,
      //   color: Colors.blueGrey,
      // ),
    ];

    setState(() {
      dishes = list;
    });
  }

  void goToSecondScreen(BuildContext context) async {
    List<Dish> dataFromSecondPage = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Cart(cartList),
        ));
    setState(() {
      cartList = dataFromSecondPage;
    });
  }

  int cross(int multiplier) {
    int myprice = multiplier * 2;
    return myprice;
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
