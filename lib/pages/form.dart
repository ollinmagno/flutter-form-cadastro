import 'package:flutter/material.dart';

class FormularioCadastro extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _controllerNome = TextEditingController();
  final _controllerLogin = TextEditingController();
  final _controllerSenha = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerCPF = TextEditingController();

  _form(String text, String hint, 
  {obscure = false, TextEditingController controller,
  FormFieldValidator<String> validator, TextInputType keyboardType,
  int maxLength}){
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscure,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines : 1,
      decoration: InputDecoration(
        labelText: text,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16,
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),
      ),
    );
  }
  _button(String text, Function onPressed){
    return Container(
      height: 40  ,
      child: RaisedButton(
        child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
        color: Colors.blue,
        onPressed: onPressed,
      ),
    );
  }

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

  _body(){
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _form('Nome', 'Informe seu nome', 
            controller: _controllerNome, validator: (String nome){
              if(nome.isEmpty){
                return 'Preencha seu nome';
              }
              return null;
            }),
            SizedBox(height: 20,),
            _form('Login', 'Login de acesso', 
            controller: _controllerLogin, validator: (String login){
              if(login.isEmpty){
                return 'Preencha o campo';
              }
              return null;
            }),
            SizedBox(height: 20,),
                        _form('Email', 'Informe seu email', keyboardType: TextInputType.emailAddress, 
            controller: _controllerEmail, validator: (String email){
              if(email.isEmpty){
                return 'Informe seu email';
              }
              return null;
            }),
            SizedBox(height: 20,),
            _form('Senha', 'Informe uma senha', obscure: true,
            controller: _controllerSenha, validator: (String senha){
              if(senha.isEmpty){
                return 'Informe uma senha';
              } else if(senha.length < 8){
                return 'Senha precisa ter pelo menos 8 caracteres';
              }
              return null;
            }),
            SizedBox(height: 20,),
            _form('CPF: ', 'Informe seu CPF', keyboardType: TextInputType.number,
            controller: _controllerCPF, maxLength: 11),
            _button('Cadastrar', _onClick),
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
      body: _body(),
    );
  }  
}