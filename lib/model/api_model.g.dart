// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeModel _$ExchangeModelFromJson(Map<String, dynamic> json) =>
    ExchangeModel(
      success: json['success'] as bool,
      timestamp: json['timestamp'] as int,
      base: json['base'] as String,
      date: json['date'] as String,
      rates: Rates.fromJson(json['rates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExchangeModelToJson(ExchangeModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'timestamp': instance.timestamp,
      'base': instance.base,
      'date': instance.date,
      'rates': instance.rates,
    };
