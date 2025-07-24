import 'dart:convert';
import 'dart:ui';

import 'package:logger/logger.dart';
import 'package:http/http.dart';


class NetworkResponse {
  final int statusCode;
  final String? errorMassage;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;

  NetworkResponse( {required this.statusCode,required this.isSuccess, this.errorMassage, this.responseData});
}

class NetworkClient {
  final Logger _logger = Logger();
  final VoidCallback onUnAuthorize ;
  final String _defaultMassage = "Something Went Wrong";
  final Map<String, String> Function() commonHeaders;

  NetworkClient({required this.onUnAuthorize, required this.commonHeaders});

  Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
    _logRequest(url,header: commonHeaders()); /// Logger Request
      final Response response = await get(uri, headers: commonHeaders());
      _logResponse(response); /// Logger Response
      if(response.statusCode == 200 || response.statusCode ==201){
        final responseBody = jsonDecode(response.body);
        return NetworkResponse(statusCode: 200, responseData:responseBody, isSuccess: true);
      }else if(response.statusCode==401){
        onUnAuthorize();
        return NetworkResponse(statusCode: 401,errorMassage: "UnAuthorize", isSuccess: false, );
      }else{
        final responseBody = jsonDecode(response.body);
        return NetworkResponse(statusCode: response.statusCode,responseData: responseBody["msg"] ?? _defaultMassage, isSuccess: false);
      }
    } on Exception catch (e) {
      return NetworkResponse(statusCode: -1,errorMassage: e.toString(), isSuccess: false);
    }
  }
  Future<NetworkResponse> postRequest(String url, Map<String, dynamic>?body) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url,header: commonHeaders(),body:  body); /// Logger Request
      final Response response = await post(uri, headers: commonHeaders(), body: jsonEncode(body));
      _logResponse(response); /// Logger Response
      if(response.statusCode == 200 || response.statusCode ==201){
        final responseBody = jsonDecode(response.body);
        return NetworkResponse(statusCode: 200, responseData:responseBody, isSuccess: true);
      }else if(response.statusCode==401){
        onUnAuthorize();
        return NetworkResponse(statusCode: 401,errorMassage: "UnAuthorize", isSuccess: false, );
      }else{
        final responseBody = jsonDecode(response.body);
        return NetworkResponse(statusCode: response.statusCode,responseData: responseBody["msg"] ?? _defaultMassage, isSuccess: false);
      }
    } on Exception catch (e) {
      return NetworkResponse(statusCode: -1,errorMassage: e.toString(), isSuccess: false);
    }
  }
  Future<NetworkResponse> putRequest(String url, Map<String, dynamic>?body) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url,header: commonHeaders()); /// Logger Request
      final Response response = await put(uri, headers: commonHeaders(), body: jsonEncode(body));
      _logResponse(response); /// Logger Response
      if(response.statusCode == 200 || response.statusCode ==201){
        final responseBody = jsonDecode(response.body);
        return NetworkResponse(statusCode: 200, responseData:responseBody, isSuccess: true);
      }else if(response.statusCode==401){
        onUnAuthorize();
        return NetworkResponse(statusCode: 401,errorMassage: "UnAuthorize", isSuccess: false, );
      }else{
        final responseBody = jsonDecode(response.body);
        return NetworkResponse(statusCode: response.statusCode,responseData: responseBody["msg"] ?? _defaultMassage, isSuccess: false);
      }
    } on Exception catch (e) {
      return NetworkResponse(statusCode: -1,errorMassage: e.toString(), isSuccess: false);
    }
  }
  Future<NetworkResponse> patchRequest(String url, Map<String, dynamic>?body) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url,header: commonHeaders()); /// Logger Request
      final Response response = await patch(uri, headers: commonHeaders(), body: jsonEncode(body));
      _logResponse(response); /// Logger Response
      if(response.statusCode == 200 || response.statusCode ==201){
        final responseBody = jsonDecode(response.body);
        return NetworkResponse(statusCode: 200, responseData:responseBody, isSuccess: true);
      }else if(response.statusCode==401){
        onUnAuthorize();
        return NetworkResponse(statusCode: 401,errorMassage: "UnAuthorize", isSuccess: false, );
      }else{
        final responseBody = jsonDecode(response.body);
        return NetworkResponse(statusCode: response.statusCode,responseData: responseBody["msg"] ?? _defaultMassage, isSuccess: false);
      }
    } on Exception catch (e) {
      return NetworkResponse(statusCode: -1,errorMassage: e.toString(), isSuccess: false);
    }
  }
  Future<NetworkResponse> deleteRequest(String url, Map<String, dynamic>?body) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url,header: commonHeaders()); /// Logger Request
      final Response response = await delete(uri, headers: commonHeaders(), body: jsonEncode(body));
      _logResponse(response); /// Logger Response
      if(response.statusCode == 200 || response.statusCode ==201){
        final responseBody = jsonDecode(response.body);
        return NetworkResponse(statusCode: 200, responseData:responseBody, isSuccess: true);
      }else if(response.statusCode==401){
        onUnAuthorize();
        return NetworkResponse(statusCode: 401,errorMassage: "UnAuthorize", isSuccess: false, );
      }else{
        final responseBody = jsonDecode(response.body);
        return NetworkResponse(statusCode: response.statusCode,responseData: responseBody["msg"] ?? _defaultMassage, isSuccess: false);
      }
    } on Exception catch (e) {
      return NetworkResponse(statusCode: -1,errorMassage: e.toString(), isSuccess: false);
    }
  }

  void _logRequest(String url, {Map<String , String >?header, Map<String , dynamic>?body}){
    final String message = '''
    URL -> $url
    HEADER -> $header
    BODY -> $body
    ''';
    _logger.i(message);
  }

  void _logResponse(Response response){
    final String message=
    '''
    URL -> ${response.request?.url}
    STATUS CODE -> ${response.statusCode}
    HEADER -> ${response.request?.headers}
    BODY -> ${response.body}
    
    ''';
    _logger.i(message);
  }
}
