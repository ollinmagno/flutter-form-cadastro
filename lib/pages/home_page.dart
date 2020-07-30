import 'package:flutter/material.dart';
import 'package:form_cadastro/api/login_api.dart';
import 'package:form_cadastro/pages/form.dart';
import 'package:form_cadastro/utils/nav.dart';
import 'package:form_cadastro/widgets/app_text.dart';
import 'package:form_cadastro/widgets/button.dart';
//import 'package:form_cadastro/widgets/button.dart';

class HomePage extends StatelessWidget {
  final _controllerLogin = TextEditingController();
  final _controllerSenha = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  final _nextFocus = FocusNode();

  void _onClickLogin(context) async {
    _validate();
    String login = _controllerLogin.text;
    String senha = _controllerSenha.text;

    print('$login, $senha');
    bool ok = await LoginApi.login(login, senha);
    if(ok){
      push(context, FormularioCadastro());
    }else {
      print("Login incorreto");
    }
  }

  _validate() {
    if (!_loginKey.currentState.validate()) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginKey,
        child: Container(
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
                height: 20,
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
              Container(
                width: double.infinity,
                child: Button('Entrar', onPressed:(){
                  _onClickLogin(context);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
