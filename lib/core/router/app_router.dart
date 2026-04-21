import 'package:go_router/go_router.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/auth/presentation/screens/login_screen.dart';
import 'package:myfinanceapp/features/auth/presentation/screens/signup_screen.dart';
import 'package:myfinanceapp/features/bills/presentation/screens/bills_screen.dart';
import 'package:myfinanceapp/features/home/presentation/screens/home_screen.dart';

final appRouter = GoRouter(initialLocation: '/home', routes: [
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
      StatefulShellBranch(routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      ],),
      StatefulShellBranch(routes: [
        GoRoute(
            path: '/bills', builder: (context, state) => const BillsScreen(),),
      ],),
      StatefulShellBranch(routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      ],),
      StatefulShellBranch(routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      ],),
      StatefulShellBranch(routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      ],),
    ],
  ),
],);
