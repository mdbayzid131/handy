import 'package:flutter/material.dart';

class GiveFundModel {
  final String id;
  final String title;
  final String desc;
  final IconData icon;
  final Color color;

  GiveFundModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.icon,
    required this.color,
  });

  factory GiveFundModel.fromJson(Map<String, dynamic> json) {
    return GiveFundModel(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['name'] ?? '',
      desc: json['description'] ?? '',
      icon: _getIconData(json['icon']),
      color: _getColor(json['color']),
    );
  }

  static Color _getColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) return Colors.blue;
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static IconData _getIconData(String? iconName) {
    switch (iconName) {
      case 'attach_money':
        return Icons.attach_money;
      case 'favorite':
        return Icons.favorite;
      case 'star':
        return Icons.star;
      case 'language':
        return Icons.language;
      default:
        return Icons.monetization_on;
    }
  }
}

class BankDetailsModel {
  final String accountName;
  final String sortCode;
  final String accountNumber;
  final String reference;
  final String note;

  BankDetailsModel({
    required this.accountName,
    required this.sortCode,
    required this.accountNumber,
    required this.reference,
    required this.note,
  });

  factory BankDetailsModel.fromJson(Map<String, dynamic> json) {
    return BankDetailsModel(
      accountName: json['accountName'] ?? '',
      sortCode: json['sortCode'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      reference: json['reference'] ?? '',
      note: json['note'] ?? '',
    );
  }
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

  factory GiveHistoryModel.fromJson(Map<String, dynamic> json) {
    // For formatting like "£250.00"
    String currencySymbol = json['currency'] == 'GBP' ? '£' : (json['currency'] ?? '');
    String amt = json['amount'] != null ? json['amount'].toString() : '0';

    return GiveHistoryModel(
      title: json['fund'] ?? 'Unknown',
      amount: '$currencySymbol$amt',
      date: json['date'] ?? '',
      status: json['status'] ?? 'pending',
    );
  }
}
