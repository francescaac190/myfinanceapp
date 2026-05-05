import 'package:myfinanceapp/features/home/data/datasources/home_overview_remote_datasource.dart';
import 'package:myfinanceapp/features/home/data/models/home_overview_model.dart';
import 'package:myfinanceapp/features/home/domain/repositories/home_overview_repository.dart';

class HomeOverviewRepositoryImpl implements HomeOverviewRepository {
  HomeOverviewRepositoryImpl(this._remote);
  final HomeOverviewRemoteDataSource _remote;

  @override
  Future<HomeOverviewModel> getHomeOverview() => _remote.getHomeOverview();
}
