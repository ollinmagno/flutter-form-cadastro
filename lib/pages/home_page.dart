import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:form_cadastro/api/api.dart';
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
  final _controllerSenha = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  final _nextFocus = FocusNode();

  _validate() {
    if (!_loginKey.currentState.validate()) {
      return;
    }
  }

  void _onClickLogin() async {
    _validate();
    String login = _controllerLogin.text;
    String senha = _controllerSenha.text;

    print('$login, $senha');
    bool ok = await LoginApi.login(login, senha);
    if (ok) {
      push(context, FormularioCadastro());
    } else {
      print("Login incorreto");
    }
  }

  _onClickLoginGoogle() async {
    final service = FirebaseService();
    ApiResponse response = await service.loginGoogle();

    if (response.ok) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }else {
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppText(
                context,
                'Login',
                'Digite o login',
                controller: _controllerLogin,
                nextFocus: _nextFocus,
              ),
              SizedBox(
                height: 12,
              ),
              AppText(
                context,
                'Senha',
                'Digite sua senha',
                controller: _controllerSenha,
                obscure: true,
                focusNode: _nextFocus,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 55,
                    width: double.infinity,
                    child: Button('Entrar', onPressed: () {
                      _onClickLogin();
                    }),
                  ),
                  SizedBox(
                    height: 20,
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
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('cadastrar');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormularioCadastro()));
                    },
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                          fontSize: 19,
                          decoration: TextDecoration.underline,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold),
                    ),
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
