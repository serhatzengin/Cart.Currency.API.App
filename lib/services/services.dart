import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sigma_basket_app/model/api_model.dart';

class Currency {
  Future<ExchangeModel> sendAndGet() async {
    var dio = Dio();
    ExchangeModel? model;
    try {
      const String myAccesKey = "e4b85fd2ba60c017a9318ba9b0b51c13&format=1";
      final response = await dio.get(
          'http://api.exchangeratesapi.io/v1/latest?access_key=${myAccesKey}');

      if (response.statusCode == HttpStatus.ok) {
        model = ExchangeModel.fromJson(response.data);
        return model;
      }
      // debugPrint(response.toString());
      // debugPrint(response.data['rates']['TRY'].toString());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return model!;
  }
}
