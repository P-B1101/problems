import 'package:go_router/go_router.dart';
import 'package:problems/main.dart';
import 'package:problems/sudoku_page.dart';

import 'queen_page.dart';

abstract final class AppRouter {
  static final appRouting = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(),
        routes: [
          GoRoute(
            path: '/${QueenPage.route}',
            name: QueenPage.route,
            builder: (context, state) => const QueenPage(),
          ),
          GoRoute(
            path: '/${SudokuPage.route}',
            name: SudokuPage.route,
            builder: (context, state) => const SudokuPage(),
          ),
        ],
      ),
    ],
  );
}
