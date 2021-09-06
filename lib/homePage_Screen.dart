import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:projet_testosterone/constants.dart';
import 'package:projet_testosterone/models/questions.dart';
import 'package:projet_testosterone/score_screen.dart';

import 'data.dart';
import 'models/reponses.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int score = 0;
  int scorePrecedent = 0;
  int currentQuestion = 0;
  int indexQuestion = 0;
  int resultatFinal = 0;
  bool isPressed = false;
  List<Reponse>? _reponses;
  List<Question>? _questions;

  infoScore() {
    if (score >= 17 && score < 24) {
      return Text(
        'Si vous souffrez de quelques « troubles », il y a fort à parier que ce n’est pasdû à votre testostérone. Félicitations, votre taux de testostérone est sansdoute dans la moyenne.',
        style: GoogleFonts.oswald(color: Colors.black),
      );
      print(
          'Si vous souffrez de quelques « troubles », il y a fort à parier que ce n’est pasdû à votre testostérone. Félicitations, votre taux de testostérone est sansdoute dans la moyenne.');
    } else if (score >= 24 && score < 32) {
      return Text(
          'Il est possible que vous manquiez légèrement de testostérone. Ce n’est pas un problème. Surveillez votre alimentation (je vous en parle dans ma prochaine lettre), faites de l’exercice, et cela devrait aller mieux. N’hésitez pas à mesurer votre taux de testostérone avec une prise de sang si cela vous inquiète.');
    } else if (score >= 32 && score < 47) {
      return Text(
          "Votre taux de testostérone est probablement en-dessous de la norme. Prenez au sérieux les conseils de ma prochaine lettre et mettez-les en application – cela devrait changer la donne pour vous. N’hésitez pas à mesurer votre taux de testostérone avec une prise de sang si cela vous inquiète.");
    } else if (score >= 47) {
      return Text(
          "Il y a sans doute un vrai problème avec votre taux de testostérone. Heureusement, ce n’est pas une fatalité. Vous pouvez sécréter beaucoup plus de testostérone naturellement grâce aux 11 conseils de ma prochaine lettre. Vous devriez consulter un médecin et mesurer votre taux de testostérone, histoire de tirer les choses au clair.");
    }
  }

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  static List<Reponse>? parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Reponse>((json) => Reponse.fromJson(json)).toList();
  }

  //Future method to read the URL
  fetchInfoReponse() async {
    final response = await http.get(Uri.http(ipAddress, "reponses"));
    final jsonresponse = parseResponse(response.body);
    if (mounted) {
      setState(() {
        _reponses = jsonresponse;
        print(_reponses);
      });
    }
  }

  static List<Question>? parseResponsee(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Question>((json) => Question.fromJson(json)).toList();
  }

  //Future method to read the URL
  fetchInfoQuestion() async {
    final response = await http.get(Uri.http(ipAddress, "questions"));
    final jsonresponse = parseResponsee(response.body);
    if (mounted) {
      setState(() {
        _questions = jsonresponse;
        print(_questions);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reponses = [];
    _questions = [];
    fetchInfoReponse();
    fetchInfoQuestion();
  }

  @override
  Widget build(BuildContext context) {
    String hexString = "F1F0F0";
    Size size = MediaQuery.of(context).size;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                          onTap: () {
                            setState(() {
                              isPressed == true;
                              if (currentQuestion + 1 < _questions!.length) {
                                --currentQuestion;
                                --indexQuestion;
                                print(scorePrecedent);
                              }
                            });
                          },
                          child: Expanded(flex: 2, child: Text("Précedent")),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(10),
                  child: new CircularPercentIndicator(
                      progressColor: Colors.amber,
                      radius: 130.0,
                      lineWidth: 12.0,
                      animation: false,
                      percent: double.parse(
                                  "${currentQuestion / _questions!.length * 100} ")
                              .round() /
                          100,
                      center: new Text(
                        "${currentQuestion + 1}/${questions!.length}",
                        style: new TextStyle(fontSize: 18.0),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.only(left: 240),
              child: Text(
                "Question N${currentQuestion + 1}",
                style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.headline6,
                    fontSize: 22,
                    color: Colors.amber),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.only(left: 220),
              child: Text(
                _questions!.length != 0
                    ? _questions![indexQuestion].question.toString()
                    : 'No Question',
                style: GoogleFonts.oswald(
                    letterSpacing: 0,
                    textStyle: Theme.of(context).textTheme.headline6,
                    fontSize: 22,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10,
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
                ),
                Container(
                  margin: EdgeInsets.only(right: 6),
                  width: 750,
                  height: 450,
                  child: ListView.builder(
                    itemCount: _reponses!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _onSelected(index);
                          setState(() {
                            score +=
                                int.parse(_reponses![index].value.toString());
                          });
                          print(scorePrecedent);
                          print(score);
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: _selectedIndex != null &&
                                            _selectedIndex == index
                                        ? Colors.amber
                                        : Color(int.parse("0xff${hexString}")),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Container(
                                          height: 32,
                                          width: 32,
                                          color: _selectedIndex != null &&
                                                  _selectedIndex == index
                                              ? Colors.white
                                              : Colors.amber,
                                          child: Center(
                                              child: Text(
                                            '${_reponses![index].value.toString()}',
                                            style: GoogleFonts.oswald(
                                                color: _selectedIndex != null &&
                                                        _selectedIndex == index
                                                    ? Colors.amber
                                                    : Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${_reponses![index].reponse.toString()}',
                                              style: GoogleFonts.oswald(
                                                  color:
                                                      _selectedIndex != null &&
                                                              _selectedIndex ==
                                                                  index
                                                          ? Colors.white
                                                          : Colors.grey[500],
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 380),
              width: 200,
              height: 60,
              child: RaisedButton(
                color: Colors.amber,
                onPressed: () {
                  setState(() {
                    if (currentQuestion + 1 < questions!.length) {
                      ++currentQuestion;
                      ++indexQuestion;
                    } else if (currentQuestion + 1 >= questions!.length) {
                      //showAlertDialog(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  new ScoreScreen(score: score)));
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        currentQuestion + 1 >= questions!.length
                            ? "Resultat"
                            : 'Suivant',
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
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Test Testosterone",
        style: GoogleFonts.oswald(color: Colors.blue),
      ),
      content: infoScore(),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
