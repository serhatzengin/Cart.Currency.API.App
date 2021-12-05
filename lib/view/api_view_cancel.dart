import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ApiView extends StatefulWidget {
  const ApiView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ApiViewState createState() => _ApiViewState();
}

class _ApiViewState extends State<ApiView> {
  @override
  void initState() {
    super.initState();
    sendAndGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: sendAndGet,
              child: const Text("Take It"),
            ),
            // ElevatedButton(
            //   onPressed: takeAndGet,
            //   child: const Text("Take It 2"),
            // ),
          ],
        ),
      ),
    );
  }

  /// More examples see https://github.com/flutterchina/dio/tree/master/example
  Future<String> sendAndGet() async {
    var dio = Dio();
    final response = await dio.get(
        'http://api.exchangeratesapi.io/v1/latest?access_key=e4b85fd2ba60c017a9318ba9b0b51c13&format=1');

    debugPrint(response.toString());
    debugPrint(response.data['rates']['TRY'].toString());

    final resultS = response.data['rates']['TRY'].toString();

    return resultS;
  }

  // takeAndGet() async {
  //   var dio = Dio();

  //   Response<Map> response;
  //   response = await dio.get(
  //       'http://api.exchangeratesapi.io/v1/latest?access_key=e4b85fd2ba60c017a9318ba9b0b51c13&format=1');
  //   Map? responseBody = response.data;
  //   debugPrint(responseBody.toString());
  // }
}
