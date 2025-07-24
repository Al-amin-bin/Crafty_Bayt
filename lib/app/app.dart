import 'package:crafty_bay/app/app_routes.dart';
import 'package:crafty_bay/app/app_theame.dart';
import 'package:crafty_bay/app/controller_binding.dart';
import 'package:crafty_bay/features/auth/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: SplashScreen.name,
      onGenerateRoute: AppRoutes.routes,

      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeData,
      initialBinding: ControllerBindings(),
    );
  }
}
