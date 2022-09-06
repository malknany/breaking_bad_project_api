import 'package:flutter/material.dart';
import 'package:flutter_api/app_router.dart';

void main() {
  runApp(BreakingBadApp());
}

class BreakingBadApp extends StatelessWidget {
  AppRouter appRouter=AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}