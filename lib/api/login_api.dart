import 'package:http/http.dart' as http;

class LoginApi {
  static Future<bool> login(String login, String senha) async{
    const String url = "http://livrowebservices.com.br/rest/login";

    Map params = {
      "login" : login,
      "senha" : senha,
    };
    final response = await http.post(url, body: params);
    print('Response body: ${response.body}');
    print('Response status: ${response.statusCode}');

    if(response.statusCode == 200){
      return true;
    }
    return false;
  }
}