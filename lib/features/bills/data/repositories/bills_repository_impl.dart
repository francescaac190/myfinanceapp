import 'package:myfinanceapp/features/bills/data/datasources/bills_remote_datasource.dart';
import 'package:myfinanceapp/features/bills/domain/entities/bills.dart';
import 'package:myfinanceapp/features/bills/domain/entities/bills_summary.dart';
import 'package:myfinanceapp/features/bills/domain/repositories/bills_repository.dart';

class BillsRepositoryImpl implements BillsRepository {
  BillsRepositoryImpl(this._remote);
  final BillsRemoteDataSource _remote;

  @override
  Future<({List<Bills> data, String? nextCursor})> list({
    int limit = 20,
    String? cursor,
    String? status,
  }) =>
      _remote.list(limit: limit, cursor: cursor, status: status);

  @override
  Future<Bills> getById(String id) => _remote.getById(id);

  @override
  Future<Bills> create(CreateBillsRequest input) => _remote.create(input);

  @override
  Future<Bills> update(String id, UpdateBillsInput input) =>
      _remote.update(id, input);

  @override
  Future<void> delete(String id) => _remote.delete(id);

  @override
  Future<BillsSummary> getSummary() => _remote.getSummary();

  @override
  Future<void> payBill(String id, Map<String, dynamic> body) =>
      _remote.payBill(id, body);
}
