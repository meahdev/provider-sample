import 'package:flutter/material.dart';
import 'package:flutter_provider_test/application/provider/dashboard/dashboard_provider.dart';
import 'package:flutter_provider_test/application/provider/notification/notification_provider.dart';
import 'package:flutter_provider_test/application/provider/splash/splash_provider.dart';
import 'package:flutter_provider_test/core/routes.dart';
import 'package:flutter_provider_test/infrastrcture/notification/notification_repo.dart';
import 'package:flutter_provider_test/presentation/dashboard/dashboard_screen.dart';
import 'package:flutter_provider_test/presentation/notification/notification_screen.dart';
import 'package:flutter_provider_test/presentation/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'infrastrcture/dashboard/dashboard_repo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      //
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(
            create: (_) => DashBoardProvider(DashboardRepo())),
        ChangeNotifierProvider(create: (context) => NotificationProvider(NotificationRepo())),

      ],
        child:
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: Routes.splash,
          routes: {
            Routes.splash:(_)=> const SplashScreen(),
            Routes.dashboard: (_) => const DashboardScreen(),
            Routes.notification: (_) => const NotificationScreen()
          },
          // home: const SplashScreen(),
        ),
    );
  }
}
