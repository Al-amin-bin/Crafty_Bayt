import 'package:crafty_bay/features/Common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:crafty_bay/features/Common/ui/widgets/productCategoryItem.dart';
import 'package:crafty_bay/features/Common/ui/controllers/catagory_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  static final String name = "/category";

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryListController _categoryListController = Get.find<CategoryListController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_loadMoreData);
    super.initState();
  }
  _loadMoreData(){
    if(_scrollController.position.extentAfter <300){
      _categoryListController.getCategoryList();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: Get.find<MainBottomNavController>().goToHome, icon: Icon(Icons.arrow_back_ios_new_sharp)),
        title: Text("Category",),
      ),
      body:GetBuilder<CategoryListController>(
        builder: (controller) {
          if(controller.initialLoadingInProgress){
            return CircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    itemCount: controller.categoryModelList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 8
                      ),
                      itemBuilder: (context, index){
                        return FittedBox(child: ProductCategoryItem(category: controller.categoryModelList[index],));

                  }),
                ),
                Visibility(
                  visible: controller.categoryListInProgress,
                    child: LinearProgressIndicator())
              ],
            ),
          );
        }
      ),
    );
  }
}
