import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_provider_test/application/provider/dashboard/dashboard_provider.dart';
import 'package:flutter_provider_test/application/provider/splash/splash_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/routes.dart';
import '../../core/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<SplashProvider>(context, listen: false);
      provider.moveToDashBoard(context);
    });
    return Scaffold(
      body: _bodyView(),
    );
  }

  Container _bodyView() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: _buildText(),
    );
  }

  Text _buildText() {
    return Text(
      AppStrings.splashTitle,
      style: GoogleFonts.roboto(
          color: AppColors.primaryColor,
          fontSize: 35,
          fontWeight: FontWeight.w900),
    );
  }
}
