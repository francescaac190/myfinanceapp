import 'package:dio/dio.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/home/data/models/home_overview_model.dart';

class HomeOverviewRemoteDataSource {
  HomeOverviewRemoteDataSource(this._dio);
  final Dio _dio;

  Future<HomeOverviewModel> getHomeOverview() {
    return apiCall(() async {
      final res =
          await _dio.get<Map<String, dynamic>>(ApiEndpoints.homeOverview);
      return HomeOverviewModel.fromJson(res.data!);
    });
  }
}
