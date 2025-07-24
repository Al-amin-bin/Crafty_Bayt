import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/features/Common/model/user_model.dart';
import 'package:crafty_bay/features/Common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay/features/auth/data/signUpRequestModel.dart';
import 'package:crafty_bay/features/auth/data/verify_request_model.dart';
import 'package:crafty_bay/features/core/services/network/network_client.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController{
   bool _verifyInProgress = false;
  String? _errorMassage ;
  late String _massage;

  bool get verifyInProgress => _verifyInProgress;
  String? get errorMassage => _errorMassage;
  String get  massage => _massage;

  Future<bool> verify(VerifyRequestModel model) async {
    bool isSuccess = false;
    _verifyInProgress = true;
    update();
   final  NetworkResponse response = await Get.find<NetworkClient>().postRequest(Urls.verifyOtpUrl, model.toJson());
   if(response.isSuccess){
     Get.find<AuthController>().saveUserData(
         response.responseData!['data']['token'],
         UserModel.fromJson(response.responseData!['data']['user']));
     _massage = response.responseData!['msg'];
     isSuccess = true;
     _errorMassage = null;

   }else{
     response.errorMassage;
   }
   _verifyInProgress = false;
   update();
   return isSuccess;

  }
}