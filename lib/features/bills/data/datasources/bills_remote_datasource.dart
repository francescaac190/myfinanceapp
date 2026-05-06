import 'package:dio/dio.dart';
import 'package:myfinanceapp/features/bills/data/models/bills_model.dart';
import 'package:myfinanceapp/features/bills/domain/entities/bills.dart';
import 'package:myfinanceapp/features/bills/domain/entities/bills_summary.dart';

class BillsRemoteDataSource {
  BillsRemoteDataSource(this._dio);
  final Dio _dio;

  Future<({List<Bills> data, String? nextCursor})> list({
    int limit = 20,
    String? cursor,
    String? status,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/bills',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
        if (status != null) 'status': status,
      },
    );
    final data = (res.data!['data'] as List)
        .map((e) => BillsModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final nextCursor = res.data!['nextCursor'] as String?;
    return (data: data, nextCursor: nextCursor);
  }

  Future<Bills> getById(String id) async {
    final res = await _dio.get<Map<String, dynamic>>('/bills/$id');
    return BillsModel.fromJson(res.data!);
  }

  Future<Bills> create(CreateBillsRequest input) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/bills',
      data: input.toJson(),
    );
    return BillsModel.fromJson(res.data!);
  }

  Future<Bills> update(String id, UpdateBillsInput input) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/bills/$id',
      data: input.toJson(),
    );
    return BillsModel.fromJson(res.data!);
  }

  Future<void> delete(String id) async {
    await _dio.delete<void>('/bills/$id');
  }

  Future<BillsSummary> getSummary() async {
    final res = await _dio.get<Map<String, dynamic>>('/bills/summary');
    final json = res.data!;
    return BillsSummary(
      pending: json['pending'] as int,
      paid: json['paid'] as int,
      overdue: json['overdue'] as int,
      upcomingTotal: json['upcomingTotal'].toString(),
    );
  }

  Future<void> payBill(String id, Map<String, dynamic> body) async {
    await _dio.post<void>('/bills/$id/mark-paid', data: body);
  }
}
