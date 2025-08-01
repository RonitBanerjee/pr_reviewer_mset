import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr_reviewer/routing/app_router_config.dart';
import 'package:pr_reviewer/screens/auth/login.dart';
import 'package:pr_reviewer/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PR Wizard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      routerConfig: MyAppRouter.router,
    );
  }
}
