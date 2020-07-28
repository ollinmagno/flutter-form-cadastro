import 'package:flutter/material.dart';

class Button extends StatelessWidget {
    String text;
    Function onPressed;

    Button(this.text, {this.onPressed});
    @override
    Widget build(BuildContext context){
        return Container(
        height: 40,
        child: RaisedButton(
            child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
            color: Colors.blue,
            onPressed: onPressed,
        ),
    );
    }
}