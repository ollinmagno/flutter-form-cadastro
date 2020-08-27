import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:form_cadastro/api/api_response.dart';
import 'package:form_cadastro/api/login_api.dart';
import 'package:form_cadastro/firebase/firebase_service.dart';
import 'package:form_cadastro/pages/form.dart';
import 'package:form_cadastro/pages/home_screen.dart';
import 'package:form_cadastro/utils/nav.dart';
import 'package:form_cadastro/widgets/app_text.dart';
import 'package:form_cadastro/widgets/button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controllerLogin = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  final _nextFocus = FocusNode();

  _validate() {
    if (!_loginKey.currentState.validate()) {
      return;
    }
  }

  Future<ApiResponse<bool>> _onClickLogin() async {
    _validate();
    final String login = _controllerLogin.text;
    final String password = _controllerPassword.text;

    print('$login, $password');
    await LoginApi.login(login, password).then
    ((successfullyLoggedIn) {
      if(successfullyLoggedIn == true){
        push(context, HomeScreen());
      }
      return false;
    });
  }

  Future<void>_onClickLoginGoogle() async {
    final FirebaseService service = FirebaseService();
    ApiResponse response = await service.loginGoogle();

    if (response.ok) {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      print('${response.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginKey,
        child: Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppText(
                context,
                "Login",
                "Digite o login",
                controller: _controllerLogin,
                nextFocus: _nextFocus,
                validator: (String text) {
                  if(text.isEmpty){
                    return "Informe seu usuário";
                  }
                  return null;
                }
              ),
              const SizedBox(
                height: 12,
              ),
              AppText(
                context,
                "Senha",
                "Digite sua senha",
                controller: _controllerPassword,
                obscure: true,
                focusNode: _nextFocus,
                validator: (String text) {
                  if(text.isEmpty){
                    return "Informe sua senha";
                  }
                  return null;
                }
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 55,
                    width: double.infinity,
                    child: Button("ENTRAR", onPressed: () {
                      _onClickLogin();
                    }),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 55,
                    width: double.infinity,
                    child: GoogleSignInButton(
                      onPressed: () {
                        _onClickLoginGoogle();
                      },
                      darkMode: false,
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 3, right: 16),
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("cadastrar");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FormularioCadastro()));
                        },
                        child: Text(
                         "Cadastrar",
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 16, right: 3),
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
