
import 'package:crafty_bay/features/Common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay/features/Common/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/features/auth/ui/screens/sinup_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static final String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoNextScreen();
    super.initState();
  }
  
  Future<void> gotoNextScreen()async {
    await Future.delayed(Duration(seconds: 3));
    await Get.find<AuthController>().getUserData();
    Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding( 
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Spacer(),
              AppLogo(),
              Spacer(),
              CircularProgressIndicator(),
              SizedBox(height: 12,),
              Text("Version 1.0.0",style: TextStyle(color: Colors.grey),)
            ],
          ),
        ),
      ),
    );
  }
}


