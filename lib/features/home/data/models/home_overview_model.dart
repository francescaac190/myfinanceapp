import 'package:myfinanceapp/features/home/domain/entities/home_overview_entity.dart';

class HomeOverviewModel extends HomeOverview {
  HomeOverviewModel({
    required super.greeting,
    required super.totalBalance,
    required super.spendingThisMonth,
    required super.recentTransactions,
    required super.quickActions,
  });
  factory HomeOverviewModel.fromJson(Map<String, dynamic> json) =>
      HomeOverviewModel(
        greeting:
            GreetingModel.fromJson(json['greeting'] as Map<String, dynamic>),
        totalBalance: json['totalBalance'] as String,
        spendingThisMonth: SpendingThisMonthModel.fromJson(
          json['spendingThisMonth'] as Map<String, dynamic>,
        ),
        recentTransactions: List<RecentTransactionModel>.from(
          (json['recentTransactions'] as List<dynamic>).map(
            (x) => RecentTransactionModel.fromJson(x as Map<String, dynamic>),
          ),
        ),
        quickActions: List<String>.from(
          (json['quickActions'] as List<dynamic>).map((x) => x as String),
        ),
      );
}

class GreetingModel extends Greeting {
  const GreetingModel({
    required super.name,
    required super.timeOfDay,
  });

  factory GreetingModel.fromJson(Map<String, dynamic> json) => GreetingModel(
        name: json['name'] as String,
        timeOfDay: json['timeOfDay'] as String,
      );
}

class RecentTransactionModel extends RecentTransaction {
  RecentTransactionModel({
    required super.id,
    required super.description,
    required super.amount,
    required super.type,
    required super.occurredAt,
    required super.category,
  });

  factory RecentTransactionModel.fromJson(Map<String, dynamic> json) =>
      RecentTransactionModel(
        id: json['id'] as String,
        description: json['description'] as String,
        amount: json['amount'] as String,
        type: json['type'] as String,
        occurredAt: DateTime.parse(json['occurredAt'] as String),
        category: RecentTransactionCategoryModel.fromJson(
          json['category'] as Map<String, dynamic>,
        ),
      );
}

class RecentTransactionCategoryModel extends RecentTransactionCategory {
  RecentTransactionCategoryModel({
    required super.name,
    required super.color,
    required super.icon,
  });

  factory RecentTransactionCategoryModel.fromJson(Map<String, dynamic> json) =>
      RecentTransactionCategoryModel(
        name: json['name'] as String,
        color: json['color'] as String,
        icon: json['icon'] as String,
      );
}

class SpendingThisMonthModel extends SpendingThisMonth {
  SpendingThisMonthModel({
    required super.total,
    required super.categories,
  });

  factory SpendingThisMonthModel.fromJson(Map<String, dynamic> json) =>
      SpendingThisMonthModel(
        total: json['total'] as String,
        categories: List<CategoryElementModel>.from(
          (json['categories'] as List<dynamic>).map(
            (x) => CategoryElementModel.fromJson(x as Map<String, dynamic>),
          ),
        ),
      );
}

class CategoryElementModel extends CategoryElement {
  CategoryElementModel({
    required super.name,
    required super.color,
    required super.amount,
  });

  factory CategoryElementModel.fromJson(Map<String, dynamic> json) =>
      CategoryElementModel(
        name: json['name'] as String,
        color: json['color'] as String,
        amount: json['amount'] as String,
      );
}
