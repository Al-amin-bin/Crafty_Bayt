import 'package:crafty_bay/features/Common/model/category_model.dart';
import 'package:crafty_bay/features/Common/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/features/auth/ui/screens/login_screen.dart';
import 'package:crafty_bay/features/auth/ui/screens/sinup_screen.dart';
import 'package:crafty_bay/features/auth/ui/screens/splash_screen.dart';
import 'package:crafty_bay/features/auth/ui/screens/verify_otp_screen.dart';
import 'package:crafty_bay/features/cart/ui/screens/cart_screen.dart';
import 'package:crafty_bay/features/home/ui/screens/home_screen.dart';
import 'package:crafty_bay/features/product/ui/screens/category_screen.dart';
import 'package:crafty_bay/features/product/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/features/product/ui/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    late final Widget screenWidget;

    if (settings.name == SplashScreen.name) {
      screenWidget = SplashScreen();
    }else if(settings.name == LoginScreen.name){
      screenWidget = LoginScreen();
    }else if(settings.name == SignUpScreen.name){
      screenWidget = SignUpScreen();
    }else if(settings.name == HomeScreen.name){
      screenWidget = HomeScreen();
    }else if(settings.name == CategoryScreen.name){
      screenWidget = CategoryScreen();
    }else if(settings.name == MainBottomNavScreen.name){
      screenWidget = MainBottomNavScreen();
    }else if (settings.name == VerifyOtpScreen.name) {
      final String email = settings.arguments as String;
      screenWidget = VerifyOtpScreen(email: email);
    }else if (settings.name == ProductDetailsScreen.name) {
      final String productId = settings.arguments as String;
      screenWidget = ProductDetailsScreen(productId: productId);
    } else if(settings.name == ProductListScreen.name){
      final CategoryModel categoryModel = settings.arguments as CategoryModel;
      screenWidget = ProductListScreen(category: categoryModel);
    }else if(settings.name == CartScreen.name){
      screenWidget = CartScreen();
    }
    return MaterialPageRoute(builder: (context) => screenWidget);
  }
}