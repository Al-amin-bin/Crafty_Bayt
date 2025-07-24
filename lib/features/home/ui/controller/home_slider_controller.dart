import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/features/Common/model/user_model.dart';
import 'package:crafty_bay/features/Common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay/features/auth/data/signUpRequestModel.dart';
import 'package:crafty_bay/features/auth/data/verify_request_model.dart';
import 'package:crafty_bay/features/core/services/network/network_client.dart';
import 'package:crafty_bay/features/home/ui/data/slider_model.dart';
import 'package:get/get.dart';

class HomeSliderController extends GetxController{
   bool _homeSliderInProgress = false;
  String? _errorMassage ;
  late String _massage;

  bool get homeSliderInProgress => _homeSliderInProgress;
  String? get errorMassage => _errorMassage;
  String get  massage => _massage;
  List<SliderModel> _sliderModelList = [];
  List<SliderModel> get sliderModelList=>_sliderModelList;

  Future<bool> getHomeSlider() async {
    bool isSuccess = false;
    _homeSliderInProgress = true;
    update();
   final  NetworkResponse response = await Get.find<NetworkClient>().getRequest(Urls.homeSliderUrl);
   if(response.isSuccess){
     List<SliderModel> list =[];
     for(Map<String, dynamic> slider in response.responseData!['data']['results']){
       list.add(SliderModel.fromJson(slider));
     }
     _sliderModelList = list;

     _massage = response.responseData!['msg'];
     isSuccess = true;
     _errorMassage = null;

   }else{
     response.errorMassage;
   }
   _homeSliderInProgress = false;
   update();
   return isSuccess;

  }
}