class ApiEndpoints {
  const ApiEndpoints._();

  // auth
  static const String authLogin = '/auth/login';
  static const String authRegister = '/auth/register';
  static const String authRefresh = '/auth/refresh';

  // user
  static const String usersMe = '/users/me';

  // home
  static const String homeOverview = '/home/overview';

  // wallet
  static const String accounts = '/accounts';
  static const String transactions = '/transactions';
  static const String categories = '/categories';

  // bills
  static const String bills = '/bills';
  static const String billsSummary = '/bills/summary';

  // savings
  static const String savingsGoals = '/savings/goals';
  static const String savingsSummary = '/savings/summary';

  // budgets
  static const String budgets = '/budgets';
}
