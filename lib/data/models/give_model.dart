import 'package:flutter/material.dart';

class GiveFundModel {
  final String title;
  final String desc;
  final IconData icon;
  final Color color;

  GiveFundModel({
    required this.title,
    required this.desc,
    required this.icon,
    required this.color,
  });
}

class GiveHistoryModel {
  final String title;
  final String amount;
  final String date;
  final String status;

  GiveHistoryModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
  });
}
