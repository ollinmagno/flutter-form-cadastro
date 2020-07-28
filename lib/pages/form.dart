import 'package:flutter/material.dart';
import 'package:form_cadastro/widgets/app_text.dart';
import 'package:form_cadastro/widgets/button.dart';

class FormularioCadastro extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _controllerNome = TextEditingController();
  final _controllerLogin = TextEditingController();
  final _controllerSenha = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerCPF = TextEditingController();

  final _focusLogin = FocusNode();
  final _focusEmail = FocusNode();
  final _focusSenha = FocusNode();
  final _focusCPF = FocusNode();

  void _onClick(){
    _validateForm();
    String nome = _controllerNome.text;
    String login = _controllerLogin.text;
    String senha = _controllerSenha.text;
    
    print('$nome, $login, $senha');
  }

  _validateForm(){
    bool _formOk = _formKey.currentState.validate();
    if(! _formOk){
      return;
    }
  }

  _body(context){
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            AppText(context, 'Nome', 'Informe seu nome',
            textInputAction: TextInputAction.next,
            controller: _controllerNome,
            nextFocus: _focusLogin,
            validator: (String nome){
              if(nome.isEmpty){
                return 'Preencha seu nome';
              }
              return null;
            }),
            SizedBox(height: 20,),
            AppText(context, 'Login', 'Login de acesso',
            controller: _controllerLogin,
            focusNode: _focusLogin,
            nextFocus: _focusEmail,
            validator: (String login){
              if(login.isEmpty){
                return 'Preencha o campo';
              }
              return null;
            }),
            SizedBox(height: 20,),
            AppText(context, 'Email', 'Informe seu email', keyboardType: TextInputType.emailAddress, 
            controller: _controllerEmail,
            focusNode: _focusEmail,
            nextFocus: _focusSenha,
            validator: (String email){
              if(email.isEmpty){
                return 'Informe seu email';
              }
              return null;
            }),
            SizedBox(height: 20,),
            AppText(context, 'Senha', 'Informe uma senha', obscure: true,
            controller: _controllerSenha,
            focusNode: _focusSenha,
            nextFocus: _focusCPF,
            validator: (String senha){
              if(senha.isEmpty){
                return 'Informe uma senha';
              } else if(senha.length < 8){
                return 'Senha precisa ter pelo menos 8 caracteres';
              }
              return null;
            }),
            SizedBox(height: 20,),
            AppText(context, 'CPF: ', 'Apenas números', keyboardType: TextInputType.number,
            controller: _controllerCPF,
            maxLength: 11,
            focusNode: _focusCPF,
            validator: (String cpf){
              if(cpf.isEmpty){
                return 'Informe seu CPF';
              } else if(cpf.length != 11){
                return 'CPF inválido';
              }
              return null;
            }),
            SizedBox(height: 20,),
            Button('Cadastrar', onPressed: _onClick),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }  
}