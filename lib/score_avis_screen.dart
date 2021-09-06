import 'package:flutter/material.dart';

class ScoreAvisScreen extends StatefulWidget {
  final score;
  const ScoreAvisScreen({Key? key, this.score}) : super(key: key);

  @override
  _ScoreAvisScreenState createState() => _ScoreAvisScreenState();
}

class _ScoreAvisScreenState extends State<ScoreAvisScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(widget.score),
      ),
    );
  }
}
