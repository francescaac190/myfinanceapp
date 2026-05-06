class BillsSummary {
  BillsSummary({
    required this.pending,
    required this.paid,
    required this.overdue,
    required this.upcomingTotal,
  });
  final int pending;
  final int paid;
  final int overdue;
  final String upcomingTotal;
}
