class HomeOverview {
  HomeOverview({
    required this.greeting,
    required this.totalBalance,
    required this.spendingThisMonth,
    required this.recentTransactions,
    required this.quickActions,
  });
  final Greeting greeting;
  final String totalBalance;
  final SpendingThisMonth spendingThisMonth;
  final List<RecentTransaction> recentTransactions;
  final List<String> quickActions;
}

class Greeting {
  const Greeting({
    required this.name,
    required this.timeOfDay,
  });

  final String name;
  final String timeOfDay;
}

class RecentTransaction {
  RecentTransaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.occurredAt,
    required this.category,
  });
  final String id;
  final String description;
  final String amount;
  final String type;
  final DateTime occurredAt;
  final RecentTransactionCategory category;
}

class RecentTransactionCategory {
  RecentTransactionCategory({
    required this.name,
    required this.color,
    required this.icon,
  });
  final String name;
  final String color;
  final String icon;
}

class SpendingThisMonth {
  SpendingThisMonth({
    required this.total,
    required this.categories,
  });
  final String total;
  final List<CategoryElement> categories;
}

class CategoryElement {
  CategoryElement({
    required this.name,
    required this.color,
    required this.amount,
  });

  final String name;
  final String color;
  final String amount;
}
