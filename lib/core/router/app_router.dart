import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myfinanceapp/features/auth/presentation/screens/login_screen.dart';
import 'package:myfinanceapp/features/auth/presentation/screens/signup_screen.dart';
import 'package:myfinanceapp/features/bills/presentation/screens/bills_screen.dart';
import 'package:myfinanceapp/features/home/presentation/screens/home_screen.dart';
import 'package:myfinanceapp/features/profile/presentation/screens/profile_screen.dart';
import 'package:myfinanceapp/features/savings/presentation/screens/savings_screen.dart';
import 'package:myfinanceapp/features/wallet/presentation/screens/wallet_screen.dart';

class _AuthListenable extends ChangeNotifier {
  _AuthListenable(this._bloc) {
    _sub = _bloc.stream.listen((_) => notifyListeners());
  }
  final AuthBloc _bloc;
  late final StreamSubscription<AuthState> _sub;
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

GoRouter buildRouter() {
  final bloc = getIt<AuthBloc>();
  return GoRouter(
    initialLocation: '/home',
    refreshListenable: _AuthListenable(bloc),
    redirect: (context, state) {
      final s = bloc.state;
      final loc = state.matchedLocation;
      final atAuth = loc == '/login' || loc == '/signup';

      if (s is AuthInitial || s is AuthLoading) return '/login';
      if (s is AuthUnauthenticated) return atAuth ? null : '/login';
      if (s is AuthAuthenticated)
        return atAuth || loc == '/splash' ? '/home' : null;
      return null;
    },
    routes: [
      // GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (_, __) => const SignupScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(
            currentIndex: navigationShell.currentIndex,
            child: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bills',
                builder: (context, state) => const BillsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/savings',
                builder: (context, state) => const SavingsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/wallet',
                builder: (context, state) => const WalletScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
