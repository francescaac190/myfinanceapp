import 'package:myfinanceapp/features/bills/domain/entities/bills.dart';

class BillsModel extends Bills {
  BillsModel({
    required super.id,
    required super.name,
    required super.amount,
    required super.dueDate,
    required super.categoryId,
    required super.recurrence,
    required super.status,
    required super.paidAt,
    required super.reminderDays,
    required super.autopay,
  });

  factory BillsModel.fromJson(Map<String, dynamic> json) {
    return BillsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: json['amount'].toString(),
      dueDate: DateTime.parse(json['dueDate'] as String),
      categoryId: json['categoryId'] as String,
      recurrence: json['recurrence'] as String,
      status: json['status'] as String,
      paidAt: json['paidAt'] != null
          ? DateTime.parse(json['paidAt'] as String)
          : null,
      reminderDays: json['reminderDays'] as int,
      autopay: json['autopay'] as bool,
    );
  }
}
