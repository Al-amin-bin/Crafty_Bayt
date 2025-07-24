
import 'package:crafty_bay/app/asset_image_path.dart';
import 'package:crafty_bay/features/Common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:crafty_bay/features/Common/ui/widgets/productCategoryItem.dart';
import 'package:crafty_bay/features/Common/ui/widgets/product_card.dart';
import 'package:crafty_bay/features/core/ui/widgets/center_circular_progress_.dart';
import 'package:crafty_bay/features/Common/ui/controllers/catagory_list_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/home_slider_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/new_product_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/popular_product_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/special_product_controller.dart';
import 'package:crafty_bay/features/home/ui/widgets/appBar_icon_button.dart';
import 'package:crafty_bay/features/home/ui/widgets/home_carrousel%20Slider.dart';
import 'package:crafty_bay/features/home/ui/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final String name = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _currentSlider = ValueNotifier(0);
  final CategoryListController _categoryListController = Get.find<CategoryListController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              ProductSearchBar(),
              SizedBox(
                height: 16,
              ),
              GetBuilder<HomeSliderController>(
                builder: (sliderController) {
                  if(sliderController.homeSliderInProgress){
                    return SizedBox(
                      height: 192,
                        child: CenterCircularProgressIndicator());
                  }
                  return HomeCarouselSlider(sliders: sliderController.sliderModelList,);
                }
              ),
              SizedBox(
                height: 8,
              ),
              _buildSectionHeader(
                  title: '"All Categories"',
                  seeAllOnTap: () {
                    Get.find<MainBottomNavController>().goToCategoryScreen();
                  }),
              SizedBox(
                height: 8,
              ),
              _getCategoryList(),
              SizedBox(
                height: 8,
              ),
              _buildSectionHeader(title: "Popular", seeAllOnTap: () {}),
              SizedBox(height: 8),
              _getPopularProduct(),
              SizedBox(
                height: 8,
              ),
              _buildSectionHeader(title: "Special", seeAllOnTap: () {}),
              SizedBox(height: 8),
              _getSpecialProduct(),
              SizedBox(
                height: 8,
              ),
              _buildSectionHeader(title: "New", seeAllOnTap: () {}),
              SizedBox(height: 8),
              _getNewProduct(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPopularProduct() {
    return GetBuilder<PopularProductController>(
      builder: (popularProductController) {
        return Visibility(
          visible: popularProductController.popularProductInProgress == false,
          replacement:  CenterCircularProgressIndicator(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
               children: popularProductController.productModelList.map((product) => ProductCard(productModel: product,)).toList(),
            ),
          ),
        );
      }
    );
  }
  Widget _getSpecialProduct() {
    return GetBuilder<SpecialProductController>(
      builder: (specialProductController) {
        return Visibility(
          visible: specialProductController.specialProductInProgress == false,
          replacement: CenterCircularProgressIndicator(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              children: specialProductController.productModelList.map((product) => ProductCard(productModel: product,)).toList(),
            ),
          ),
        );
      }
    );
  }
  Widget _getNewProduct() {
    return GetBuilder<NewProductController>(
      builder: (newProductController) {
        return Visibility(
          visible: newProductController.newProductInProgress == false,
          replacement: CenterCircularProgressIndicator(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
               children: newProductController.productModelList.map((product) => ProductCard(productModel: product,)).toList(),
            ),
          ),
        );
      }
    );
  }

  Widget _buildSectionHeader(
      {required String title, required VoidCallback seeAllOnTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        TextButton(
            onPressed: seeAllOnTap,
            child: Text("See All ",
                style: TextStyle(
                  fontSize: 18,
                )))
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetPath.navAppLogoPath),
      actions: [
        AppBarIconButton(
          onTap: () {},
          iconData: Icons.person,
        ),
        AppBarIconButton(
          onTap: () {},
          iconData: Icons.call,
        ),
        AppBarIconButton(
          onTap: () {},
          iconData: Icons.notifications,
        ),
      ],
    );
  }

  Widget _getCategoryList() {
    return SizedBox(
      height: 100,
      child: GetBuilder<CategoryListController>(
        builder: (controller) {
          if(controller.initialLoadingInProgress){
            return CenterCircularProgressIndicator();
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount:controller.homeScreenCategoryListItem,
            itemBuilder: (context, index) {
              return ProductCategoryItem(category: _categoryListController.categoryModelList[index],);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 8,
              );
            },
          );
        }
      ),
    );
  }
}


