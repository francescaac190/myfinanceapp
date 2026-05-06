import 'package:myfinanceapp/features/bills/domain/entities/bills.dart';
import 'package:myfinanceapp/features/bills/domain/entities/bills_summary.dart';

abstract class BillsRepository {
  Future<({List<Bills> data, String? nextCursor})> list({
    int limit,
    String? cursor,
    String? status,
  });
  Future<Bills> getById(String id);
  Future<Bills> create(CreateBillsRequest input);
  Future<Bills> update(String id, UpdateBillsInput input);
  Future<void> delete(String id);
  Future<BillsSummary> getSummary();
  Future<void> payBill(String id, Map<String, dynamic> body);
}
