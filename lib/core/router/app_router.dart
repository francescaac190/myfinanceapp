import 'package:go_router/go_router.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/auth/presentation/screens/login_screen.dart';
import 'package:myfinanceapp/features/auth/presentation/screens/signup_screen.dart';
import 'package:myfinanceapp/features/bills/presentation/screens/bills_screen.dart';
import 'package:myfinanceapp/features/home/presentation/screens/home_screen.dart';
import 'package:myfinanceapp/features/profile/presentation/screens/profile_screen.dart';
import 'package:myfinanceapp/features/savings/presentation/screens/savings_screen.dart';
import 'package:myfinanceapp/features/wallet/presentation/screens/wallet_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
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
                path: '/home', builder: (context, state) => const HomeScreen(),),
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
                builder: (context, state) => const SavingsScreen(),),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/wallet',
                builder: (context, state) => const WalletScreen(),),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),),
          ],
        ),
      ],
    ),
  ],
);
