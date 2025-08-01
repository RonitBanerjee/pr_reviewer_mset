import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pr_reviewer/routing/app_router_constants.dart';
import 'package:pr_reviewer/screens/auth/login.dart';
import 'package:pr_reviewer/screens/error_page.dart';
import 'package:pr_reviewer/screens/home/bloc/home_bloc.dart';
import 'package:pr_reviewer/screens/home/home.dart';

class MyAppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRoutes.loginRoute,
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: Login());
        },
      ),
      GoRoute(
        name: MyAppRoutes.homeRoute,
        path: '/home',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create: (context) => HomeBloc()..add(HomeInitialEvent()),
              child: Home(),
            ),
          );
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(),
  );
}
