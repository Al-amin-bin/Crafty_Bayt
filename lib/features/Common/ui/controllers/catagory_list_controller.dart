import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/features/Common/model/category_model.dart';

import 'package:crafty_bay/features/core/services/network/network_client.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController{
   bool _categoryListInProgress = false;
  String? _errorMassage ;
  late String _massage;
  final int _totalCount= 30;
  int _currentPage = 0;
  int? lastPage;
  bool _initialLoadingInProgress = false;

  bool get categoryListInProgress => _categoryListInProgress;
  bool get initialLoadingInProgress => _initialLoadingInProgress;
  String? get errorMassage => _errorMassage;
  String get  massage => _massage;
  List<CategoryModel> _categoryModelList = [];
  List<CategoryModel> get categoryModelList=>_categoryModelList;
  int get homeScreenCategoryListItem => categoryModelList.length>10 ? 10 : categoryModelList.length;

  Future<void> getCategoryList() async {
    _currentPage++;
    if(lastPage !=null && lastPage! >_currentPage){
      return;
    }

    if(_currentPage == 1){
      _initialLoadingInProgress = true;
      _categoryModelList.clear();
    }else {
      _categoryListInProgress = true;
    }

    update();
   final  NetworkResponse response = await Get.find<NetworkClient>().getRequest(Urls.categoryListUrl(_totalCount, _currentPage));
   if(response.isSuccess){
     lastPage = response.responseData!['data']['last_page'] ?? 0;
     List< CategoryModel> list =[];
     for(Map<String, dynamic> slider in response.responseData!['data']['results']){
       list.add(CategoryModel.fromJson(slider));
     }
     _categoryModelList.addAll(list);

     _massage = response.responseData!['msg'];
     _errorMassage = null;

   }else{
     response.errorMassage;
   }
    if(_currentPage == 1){
      _initialLoadingInProgress = false;
    }else {
      _categoryListInProgress = false;
    }
   update();


  }
}