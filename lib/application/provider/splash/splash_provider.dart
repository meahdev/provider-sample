import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_provider_test/core/routes.dart';

class SplashProvider extends ChangeNotifier {
  moveToDashBoard(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, Routes.dashboard);
    });
  }
}


