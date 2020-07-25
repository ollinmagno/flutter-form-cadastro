import 'package:flutter/material.dart';
import 'package:form_cadastro/pages/form.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FormularioCadastro(),
    );
  }
}