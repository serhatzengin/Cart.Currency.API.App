import 'package:json_annotation/json_annotation.dart';

import 'api_model_rates.dart';
part 'api_model.g.dart';

@JsonSerializable()
class ExchangeModel {
  ExchangeModel({
    required this.success,
    required this.timestamp,
    required this.base,
    required this.date,
    required this.rates,
  });
  late final bool success;
  late final int timestamp;
  late final String base;
  late final String date;
  late final Rates rates;

  ExchangeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    timestamp = json['timestamp'];
    base = json['base'];
    date = json['date'];
    rates = Rates.fromJson(json['rates']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['timestamp'] = timestamp;
    _data['base'] = base;
    _data['date'] = date;
    _data['rates'] = rates.toJson();
    return _data;
  }
}
