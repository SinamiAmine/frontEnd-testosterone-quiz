import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_testosterone/main.dart';

class LastPage extends StatefulWidget {
  final String nameUser;
  const LastPage({Key? key, required this.nameUser}) : super(key: key);

  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: width * 0.1,
                    margin: EdgeInsets.symmetric(vertical: 60, horizontal: 460),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/arrow_one.svg",
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Expanded(flex: 2, child: Text("Précedent")),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 450),
                  width: 300,
                  height: 400,
                  child: Image.asset("assets/images/muscle.png"),
                ),
                SizedBox(
                  height: 8,
                  width: 30,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  margin: EdgeInsets.only(right: 3),
                  width: width / 2,
                  height: 450,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Text(
                          "merci de bien vouloir vérifier Mr/Mme ${widget.nameUser} votre boîte mail pour obtenir le résultat et aussi nous avons donneé des conseills par rapport son taux de testostérone ",
                          style: GoogleFonts.oswald(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 380),
                        width: 200,
                        height: 60,
                        child: RaisedButton(
                          color: Colors.amber,
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new MyApp()));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Refaire",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_right_alt,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
