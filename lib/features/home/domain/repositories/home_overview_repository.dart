import 'package:myfinanceapp/features/home/domain/entities/home_overview_entity.dart';

abstract class HomeOverviewRepository {
  Future<HomeOverview> getHomeOverview();
}
