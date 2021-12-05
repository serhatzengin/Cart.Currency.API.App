import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sigma_basket_app/model/api_model.dart';

abstract class IHomeService {
  late final Dio _dio;
  final _path = '/latest?access_key=6426c15cf14eb545b688a179cea29b65';
  IHomeService(Dio dio) {
    _dio = dio;
  }
  Future<ExchangeModel> fetchUsers();
}


class HomeService extends IHomeService {
  HomeService(Dio dio) : super(dio);
  @override
  Future<ExchangeModel> fetchUsers() async {
    ExchangeModel? model;
    try {
      final response = await _dio.get(_path);
      if (response.statusCode == HttpStatus.ok) {
        model = ExchangeModel.fromJson(response.data);
        return model;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return model!;
  }
}
