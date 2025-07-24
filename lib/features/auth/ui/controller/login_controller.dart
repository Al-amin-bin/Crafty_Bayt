import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/features/Common/model/user_model.dart';
import 'package:crafty_bay/features/Common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay/features/auth/data/login_request_model.dart';
import 'package:crafty_bay/features/core/services/network/network_client.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
   bool _loginInProgress = false;
  String? _errorMassage ;
  late String _massage;

  bool get logInProgress => _loginInProgress;
  String? get errorMassage => _errorMassage;
  String get  massage => _massage;

  Future<bool> login(LoginRequestModel model) async {
    bool isSuccess = false;
    _loginInProgress = true;
    update();
   final  NetworkResponse response = await Get.find<NetworkClient>().postRequest(Urls.loginUrl, model.toJson());
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
   _loginInProgress = false;
   update();
   return isSuccess;

  }
}