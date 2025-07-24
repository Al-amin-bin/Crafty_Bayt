import 'package:crafty_bay/features/Common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay/features/Common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:crafty_bay/features/auth/ui/controller/login_controller.dart';
import 'package:crafty_bay/features/auth/ui/controller/signupController.dart';
import 'package:crafty_bay/features/auth/ui/controller/verify_otp_controller.dart';
import 'package:crafty_bay/features/auth/ui/screens/login_screen.dart';
import 'package:crafty_bay/features/cart/ui/controller/cart_list_controller.dart';
import 'package:crafty_bay/features/core/services/network/network_client.dart';
import 'package:crafty_bay/features/Common/ui/controllers/catagory_list_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/home_slider_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/new_product_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/popular_product_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/special_product_controller.dart';
import 'package:crafty_bay/features/product/ui/controller/add_to_cart_controller.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings{
  final AuthController _authController = AuthController();
  @override
  void dependencies() {
    Get.put(_authController);
    Get.put(MainBottomNavController());
    Get.put(
      NetworkClient(
        onUnAuthorize: _onUnAuthorize,
        commonHeaders: () {
          return _commonHeaders();
        },
      ),
    );
    Get.put(SignUpController());
    Get.put(VerifyOtpController());

    Get.put(LoginController());
    Get.put(HomeSliderController());
    Get.put(CategoryListController());
    Get.put(PopularProductController());
    Get.put(SpecialProductController());
    Get.put(NewProductController());
    Get.put(AddToCartController());
    Get.put(CartListController());
  }

void _onUnAuthorize(){
  _authController.clearUserData();
    Get.to(()=> LoginScreen());
    /// log out
}
   Map<String, String>  _commonHeaders(){
    return{
      'content-type': 'application/json',
      'token': _authController.accessToken?? ' ',
    };
    }


}