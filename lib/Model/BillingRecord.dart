import 'dart:convert';
import 'bill_model.dart';

class BillingRecord {
  final List<BillItem> items;
  final double total;
  final DateTime timestamp;

  BillingRecord(
      {required this.items, required this.total, required this.timestamp});

  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
        'total': total,
        'timestamp': timestamp.toIso8601String(),
      };

  factory BillingRecord.fromJson(Map<String, dynamic> json) => BillingRecord(
        items:
            (json['items'] as List).map((e) => BillItem.fromJson(e)).toList(),
        total: json['total'],
        timestamp: DateTime.parse(json['timestamp']),
      );

  static List<BillingRecord> decode(String billingJson) =>
      (jsonDecode(billingJson) as List)
          .map((e) => BillingRecord.fromJson(e))
          .toList();

  static String encode(List<BillingRecord> records) =>
      jsonEncode(records.map((e) => e.toJson()).toList());
}
