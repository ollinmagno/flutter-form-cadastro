import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  bool showProgress;
  Button(this.text, {this.onPressed, this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: RaisedButton(
          color: Colors.blue,
          onPressed: onPressed,
          child: showProgress
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
        ));
  }
}
