import 'package:crafty_bay/features/Common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:crafty_bay/features/Common/ui/controllers/catagory_list_controller.dart';
import 'package:crafty_bay/features/cart/ui/screens/cart_screen.dart';
import 'package:crafty_bay/features/home/ui/controller/home_slider_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/new_product_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/popular_product_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/special_product_controller.dart';
import 'package:crafty_bay/features/home/ui/screens/home_screen.dart';
import 'package:crafty_bay/features/product/ui/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});
  static final String name = "/mainBottomNav";

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
    Get.find<HomeSliderController>().getHomeSlider();
    Get.find<CategoryListController>().getCategoryList();
    Get.find<PopularProductController>().getPopularProduct();
    Get.find<SpecialProductController>().getSpecialProduct();
    Get.find<NewProductController>().getNewProduct();});
    super.initState();
  }
  final List<Widget> _screen =[
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (navController) {
        return Scaffold(
          body: _screen[navController.selectedIndex],
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: navController.changeIndex,
              selectedIndex: navController.selectedIndex,
              destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.category), label: "Category"),
            NavigationDestination(icon: Icon(Icons.shopping_cart), label: "Cart"),
            NavigationDestination(icon: Icon(Icons.favorite), label: "Wish List"),
          ])
        );
      }
    );
  }
}
