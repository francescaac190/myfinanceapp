import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myfinanceapp/features/auth/presentation/screens/login_screen.dart';
import 'package:myfinanceapp/features/auth/presentation/screens/signup_screen.dart';
import 'package:myfinanceapp/features/bills/presentation/bloc/bills_bloc.dart';
import 'package:myfinanceapp/features/bills/presentation/screens/bills_screen.dart';
import 'package:myfinanceapp/features/home/presentation/bloc/home_overview_bloc.dart';
import 'package:myfinanceapp/features/home/presentation/screens/home_screen.dart';
import 'package:myfinanceapp/features/profile/presentation/screens/profile_screen.dart';
import 'package:myfinanceapp/features/savings/presentation/screens/savings_screen.dart';
import 'package:myfinanceapp/features/wallet/presentation/screens/wallet_screen.dart';

class _AuthListenable extends ChangeNotifier {
  _AuthListenable(this._bloc) {
    _sub = _bloc.stream.listen((_) => notifyListeners());
    Future.microtask(notifyListeners);
  }
  final AuthBloc _bloc;
  late final StreamSubscription<AuthState> _sub;
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

GoRouter buildRouter({String initialLocation = '/login'}) {
  final bloc = getIt<AuthBloc>();
  return GoRouter(
    initialLocation: initialLocation,
    refreshListenable: _AuthListenable(bloc),
    redirect: (context, state) {
      final s = bloc.state;
      final loc = state.matchedLocation;
      final atAuth = loc == '/login' || loc == '/signup';

      if (s is AuthInitial || s is AuthLoading) return null;
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
                builder: (context, state) => BlocProvider(
                  create: (_) => getIt<HomeOverviewBloc>()
                    ..add(const HomeOverviewRequested()),
                  child: const HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: '/bills',
                  builder: (context, state) => BlocProvider(
                        create: (_) =>
                            getIt<BillsBloc>()..add(const BillsRequested()),
                        child: const BillsScreen(),
                      )),
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
