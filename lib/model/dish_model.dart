import 'package:flutter/material.dart';

class Dish {
  final String name;
  final IconData icon;
  final Color color;
  final int price;

  Dish({
    required this.name,
    required this.icon,
    required this.color,
    required this.price,
  });
}
