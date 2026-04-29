import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:myfinanceapp/core/api/api_endpoints.dart';
import 'package:myfinanceapp/core/api/api_exception.dart';

class MockApiService {
  MockApiService({this.latency = const Duration(milliseconds: 400)});

  final Duration latency;

  static const Map<String, String> _getFixtures = {
    ApiEndpoints.usersMe: 'assets/mock/fixtures/users_me.json',
    ApiEndpoints.homeOverview: 'assets/mock/fixtures/home_overview.json',
    ApiEndpoints.accounts: 'assets/mock/fixtures/accounts_list.json',
    ApiEndpoints.transactions: 'assets/mock/fixtures/transactions_list.json',
    ApiEndpoints.categories: 'assets/mock/fixtures/categories_list.json',
    ApiEndpoints.bills: 'assets/mock/fixtures/bills_list.json',
    ApiEndpoints.billsSummary: 'assets/mock/fixtures/bills_summary.json',
    ApiEndpoints.savingsGoals: 'assets/mock/fixtures/savings_list.json',
    ApiEndpoints.savingsSummary: 'assets/mock/fixtures/savings_summary.json',
    ApiEndpoints.budgets: 'assets/mock/fixtures/budgets_list.json',
  };

  static const Map<String, String> _postFixtures = {
    ApiEndpoints.authLogin: 'assets/mock/fixtures/auth_login.json',
    ApiEndpoints.authRegister: 'assets/mock/fixtures/auth_register.json',
    ApiEndpoints.authRefresh: 'assets/mock/fixtures/auth_refresh.json',
  };

  Future<Map<String, dynamic>> get(String path) async {
    await Future<void>.delayed(latency);
    final fixture = _getFixtures[path];
    if (fixture == null) {
      throw ApiException('No GET mock for $path', statusCode: 404);
    }
    return _loadJson(fixture);
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    await Future<void>.delayed(latency);

    if (path == ApiEndpoints.budgets) {
      final raw = await _loadJson('assets/mock/fixtures/budgets_create.json');
      return raw['_response_example_201'] as Map<String, dynamic>;
    }

    final fixture = _postFixtures[path];
    if (fixture == null) {
      throw ApiException('No POST mock for $path', statusCode: 404);
    }
    return _loadJson(fixture);
  }

  Future<Map<String, dynamic>> _loadJson(String path) async {
    final raw = await rootBundle.loadString(path);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
