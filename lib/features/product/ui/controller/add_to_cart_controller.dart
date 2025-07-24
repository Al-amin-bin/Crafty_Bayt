import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/features/core/services/network/network_client.dart';
import 'package:crafty_bay/features/product/model/product_details_model.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;


  Future<bool> addToCart(String id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkClient>().postRequest(Urls.addToCartUrl,
        {
          "product": id,
        });
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMassage!;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}