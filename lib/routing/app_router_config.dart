import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pr_reviewer/routing/app_router_constants.dart';
import 'package:pr_reviewer/screens/auth/login.dart';
import 'package:pr_reviewer/screens/error_page.dart';

CustomTransitionPage<void> noTransitionPage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class MyAppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: MyAppRoutes.loginRoute,
        path: '/',
        pageBuilder: (context, state) => noTransitionPage(Login()),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(),
  );
}
