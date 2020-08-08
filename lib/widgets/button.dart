import 'package:flutter/material.dart';

class Button extends StatelessWidget {
    final String text;
    final Function onPressed;

    Button(this.text, {this.onPressed});
    @override
    Widget build(BuildContext context){
        return Container(
        height: 50,
        child: RaisedButton(
            child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
            color: Colors.blue,
            onPressed: onPressed,
        ),
    );
    }
}