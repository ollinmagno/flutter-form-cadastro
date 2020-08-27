import 'dart:convert';
import 'package:form_cadastro/api/api_response.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<bool>> login(String login, String senha) async{
    const String url = "https://carros-springboot.herokuapp.com/api/v2/login";

    final Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    Map params = {
      "username": login,
      "password": senha,
    };
    final String jsonParams = json.encode(params);
    
    final http.Response response = await http.post
    (url, body: jsonParams, headers: headers);

    print('Response body: ${response.body}');
    print('Response status: ${response.statusCode}');
    
    try{
      if(response.statusCode == 200){
      return ApiResponse.ok();
    }
    }catch(ApiResponse){
      return ApiResponse.error();
    }
  }
}