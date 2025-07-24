import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/features/auth/data/signUpRequestModel.dart';
import 'package:crafty_bay/features/core/services/network/network_client.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
   bool _signupInProgress = false;
  String? _errorMassage ;
  late String _massage;

  bool get signupInProgress => _signupInProgress;
  String? get errorMassage => _errorMassage;
  String get  massage => _massage;

  Future<bool> signUp(SignUpRequestModel model) async {
    bool isSuccess = false;
    _signupInProgress = true;
    update();
   final  NetworkResponse response = await Get.find<NetworkClient>().postRequest(Urls.signUpUrl, model.toJson());
   if(response.isSuccess){
     _massage = response.responseData!['msg'];
     isSuccess = true;
     _errorMassage = null;

   }else{
     response.errorMassage;
   }
   _signupInProgress = false;
   update();
   return isSuccess;

  }
}