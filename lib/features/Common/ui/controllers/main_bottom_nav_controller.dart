import 'package:get/get.dart';

class MainBottomNavController extends GetxController{
  int _currentIndex = 0;
  get selectedIndex => _currentIndex;

  void changeIndex(int index){
    if(index == _currentIndex){
      return;
    }
    _currentIndex = index;
    update();
  }

  void goToCategoryScreen(){
    return changeIndex(1);
  }
  void goToHome(){
    return changeIndex(0);
  }

}