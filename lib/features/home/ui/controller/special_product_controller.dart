import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/features/Common/model/product_model.dart';
import 'package:crafty_bay/features/Common/model/user_model.dart';
import 'package:crafty_bay/features/Common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay/features/auth/data/signUpRequestModel.dart';
import 'package:crafty_bay/features/auth/data/verify_request_model.dart';
import 'package:crafty_bay/features/core/services/network/network_client.dart';
import 'package:crafty_bay/features/home/ui/data/slider_model.dart';
import 'package:get/get.dart';

class SpecialProductController extends GetxController{
   bool _specialProductInProgress = false;
  String? _errorMassage ;
  late String _massage;

  bool get specialProductInProgress => _specialProductInProgress;
  String? get errorMassage => _errorMassage;
  String get  massage => _massage;
  List<ProductModel> _productModelList = [];
  List<ProductModel> get productModelList=>_productModelList;

  Future<bool> getSpecialProduct() async {
    bool isSuccess = false;
    _specialProductInProgress = true;
    update();
   final  NetworkResponse response = await Get.find<NetworkClient>().getRequest(Urls.productsByTagUrl("Special"));
   if(response.isSuccess){
     List<ProductModel> list =[];
     for(Map<String, dynamic> product in response.responseData!['data']['results']){
       list.add(ProductModel.fromJson(product));
     }
     _productModelList = list;

     _massage = response.responseData!['msg'];
     isSuccess = true;
     _errorMassage = null;

   }else{
     response.errorMassage;
   }
   _specialProductInProgress = false;
   update();
   return isSuccess;

  }
}