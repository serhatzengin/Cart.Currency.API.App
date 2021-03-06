import 'package:flutter/material.dart';

class Product {
  final String name;
  final IconData icon;
  final Color color;
  final int price;

  Product({
    required this.name,
    required this.icon,
    required this.color,
    required this.price,
  });
}
