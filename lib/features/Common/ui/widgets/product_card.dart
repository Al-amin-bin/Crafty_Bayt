import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/constant.dart';
import 'package:crafty_bay/features/Common/model/product_model.dart';
import 'package:crafty_bay/features/product/ui/screens/product_details_screen.dart';
import 'package:flutter/material.dart';



class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key, required this.productModel,
  });
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductDetailsScreen.name,arguments: productModel.id);
      },
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.themeColor.withOpacity(0.2),
              offset: Offset(0.0, 0.7),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              width: 140,
              decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(.1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(productModel.photoUrl.first, height: 80,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    productModel.title,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${Constants.takaSign}${productModel.currentPrice}",style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color:AppColors.themeColor,
                      ),),
                      Wrap(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          Text("4.8",style: TextStyle(
                              fontSize: 12,
                              color:Colors.grey
                          ),),
                        ],
                      ),
                      Card(
                        color: AppColors.themeColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.favorite,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}