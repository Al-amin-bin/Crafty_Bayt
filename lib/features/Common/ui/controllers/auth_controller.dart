

import 'dart:convert';

import 'package:crafty_bay/features/Common/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController{
  final String _userDataKey = 'user-data';
  final String _tokenKey = 'access-token';

  UserModel? userModel;
  String? accessToken;

  Future<void> saveUserData(String token ,UserModel model) async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.setString(_userDataKey,jsonEncode( model.toJson()));
    sharedPreferences.setString(_tokenKey,token);
    userModel = model;
    accessToken = token;

  }
  Future<void> getUserData() async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? userData = sharedPreferences.getString(_userDataKey);
    String? tokenData =  sharedPreferences.getString(_tokenKey);

    if(userData!=null){
      userModel = UserModel.fromJson(jsonDecode(userData)) ;
      accessToken= tokenData;
    }

  }

  Future<bool> isUserLoggedIn()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? tokenData = sharedPreferences.getString(_tokenKey);

    if(tokenData!=null){
     await getUserData();
     return true;
    }
    return false;

  }
  Future<void> clearUserData()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.clear();

  }

}