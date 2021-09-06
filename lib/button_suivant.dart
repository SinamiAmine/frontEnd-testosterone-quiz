import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 7.0,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: InkWell(
        onTap: () {},
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.red, Colors.pink]),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          height: 48,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width: 48),
              Expanded(
                child: Center(
                  child: Text(
                    "Hello",
                  ),
                ),
              ),
              SizedBox(
                width: 48.0,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 23.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
