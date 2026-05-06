class Bills {
  Bills({
    required this.id,
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.categoryId,
    required this.recurrence,
    required this.status,
    required this.paidAt,
    required this.reminderDays,
    required this.autopay,
  });
  final String id;
  final String name;
  final String amount;
  final DateTime dueDate;
  final String categoryId;
  final String recurrence;
  final String status;
  final dynamic paidAt;
  final int reminderDays;
  final bool autopay;
}

class CreateBillsRequest {
  final String name;
  final String amount;
  final DateTime dueDate;
  final String categoryId;
  final String recurrence;
  final String status;
  final int reminderDays;
  final bool autopay;

  CreateBillsRequest({
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.categoryId,
    required this.recurrence,
    required this.status,
    required this.reminderDays,
    required this.autopay,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amount,
        'dueDate': dueDate.toIso8601String(),
        'categoryId': categoryId,
        'recurrence': recurrence,
        'status': status,
        'reminderDays': reminderDays,
        'autopay': autopay,
      };
}

class UpdateBillsInput {
  final String? name;
  final String? amount;
  final DateTime? dueDate;
  final String? categoryId;
  final String? recurrence;
  final String? status;
  final int? reminderDays;
  final bool? autopay;

  UpdateBillsInput({
    this.name,
    this.amount,
    this.dueDate,
    this.categoryId,
    this.recurrence,
    this.status,
    this.reminderDays,
    this.autopay,
  });

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (amount != null) 'amount': amount,
        if (dueDate != null) 'dueDate': dueDate!.toIso8601String(),
        if (categoryId != null) 'categoryId': categoryId,
        if (recurrence != null) 'recurrence': recurrence,
        if (status != null) 'status': status,
        if (reminderDays != null) 'reminderDays': reminderDays,
        if (autopay != null) 'autopay': autopay,
      };
}
