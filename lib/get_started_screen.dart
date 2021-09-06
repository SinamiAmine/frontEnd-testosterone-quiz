import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          height: size.height * 0.2,
          width: size.width * 0.3,
          child: RaisedButton(
            color: Colors.amber,
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.accessibility_sharp,
                  color: Colors.white,
                  size: 22,
                ),
                Text(
                  "Get Started ",
                  style: GoogleFonts.oswald(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
