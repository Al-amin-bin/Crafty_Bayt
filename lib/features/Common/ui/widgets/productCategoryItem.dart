import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/features/Common/model/category_model.dart';
import 'package:crafty_bay/features/product/ui/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class ProductCategoryItem extends StatelessWidget {
  final CategoryModel category;
  const ProductCategoryItem({
    super.key, required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.pushNamed(context, ProductListScreen.name, arguments: category);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.themeColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(8)
      
            ),
            child: Image.network(category.iconUrl,height: 35, width: 35,),
          ),
          SizedBox(height: 4,),
          Text(_getProductTitle(category.title ?? ''),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.themeColor),),
        ],
      ),
    );
  }

  _getProductTitle(String title){
    if(title.length > 9){
      return '${title.substring(0,8)}..';
    }else{
      return title;
    }
  }
}