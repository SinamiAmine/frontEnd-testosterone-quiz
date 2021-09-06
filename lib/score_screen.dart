import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:projet_testosterone/constants.dart';
import 'package:projet_testosterone/screens/last_page.dart';

class ScoreScreen extends StatefulWidget {
  final int score;

  const ScoreScreen({Key? key, required this.score}) : super(key: key);

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  String hexString = "F1F0F0";
  var _nomController = TextEditingController();
  var _prenomController = TextEditingController();
  var _mailController = TextEditingController();

  Future sendEmail({
    required String name,
    required String to_email,
    required String email,
    required String subject,
    required String message,
  }) async {
    final serviceId = 'service_wod7a0n';
    final templateId = 'template_rp6muyg';
    final userId = 'user_EK45oipvfzAlpPt7fgsyj';
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(url,
        headers: {'Content-type': 'application/json'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'to_email': to_email,
            'user_subject': "Resultat pour le test testosterone",
            'user_message': infoScore(),
          }
        }));
    print(response.body);
  }

  Future add() async {
    final response = await http.post(Uri.http(ipAddress, "/users/newuser"),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode({
          "first_name": _nomController.text,
          "last_name": _prenomController.text,
          "email": _mailController.text,
        }));
    print(response.body);
  }

  infoScore() {
    if (widget.score >= 17 && widget.score < 24) {
      return 'Si vous souffrez de quelques « troubles », il y a fort à parier que ce n’est pasdû à votre testostérone. Félicitations, votre taux de testostérone est sansdoute dans la moyenne.';
    } else if (widget.score >= 24 && widget.score < 32) {
      return 'Il est possible que vous manquiez légèrement de testostérone. Ce n’est pas un problème. Surveillez votre alimentation (je vous en parle dans ma prochaine lettre), faites de l’exercice, et cela devrait aller mieux. N’hésitez pas à mesurer votre taux de testostérone avec une prise de sang si cela vous inquiète.';
    } else if (widget.score >= 32 && widget.score < 47) {
      return "Votre taux de testostérone est probablement en-dessous de la norme. Prenez au sérieux les conseils de ma prochaine lettre et mettez-les en application – cela devrait changer la donne pour vous. N’hésitez pas à mesurer votre taux de testostérone avec une prise de sang si cela vous inquiète.";
    } else if (widget.score >= 47) {
      return "Il y a sans doute un vrai problème avec votre taux de testostérone. Heureusement, ce n’est pas une fatalité. Vous pouvez sécréter beaucoup plus de testostérone naturellement grâce aux 11 conseils de ma prochaine lettre. Vous devriez consulter un médecin et mesurer votre taux de testostérone, histoire de tirer les choses au clair.";
    }
  }
/*
  Future<void> send() async {
    final Email email = Email(
      isHTML: false,
      body: infoScore(),
      subject: "Your Test Teststerone",
      recipients: [_mailController.text],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              height: 16,
            ),
            Container(
              margin: EdgeInsets.only(left: 220),
              child: Text(
                "Remplissez le formulaire ci-dessous pour découvrir le résultat",
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
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(int.parse("0xff${hexString}")),
                                ),
                                child: TextField(
                                  controller: _nomController,
                                  decoration: InputDecoration(
                                    hintText: 'Votre Nom',
                                    hintStyle: GoogleFonts.oswald(
                                        color: Colors.grey[500], fontSize: 20),
                                    prefixIcon: Icon(Icons.person),
                                    border: InputBorder.none,
                                  ),
                                )),
                            Container(
                                alignment: Alignment.center,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(int.parse("0xff${hexString}")),
                                ),
                                child: TextField(
                                  controller: _prenomController,
                                  decoration: InputDecoration(
                                    hintText: 'Votre Prénom',
                                    hintStyle: GoogleFonts.oswald(
                                        color: Colors.grey[500], fontSize: 20),
                                    prefixIcon: Icon(Icons.person),
                                    border: InputBorder.none,
                                  ),
                                )),
                            Container(
                                alignment: Alignment.center,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(int.parse("0xff${hexString}")),
                                ),
                                child: TextField(
                                  controller: _mailController,
                                  decoration: InputDecoration(
                                    hintText: 'Votre adresse mail',
                                    hintStyle: GoogleFonts.oswald(
                                        color: Colors.grey[500], fontSize: 20),
                                    prefixIcon:
                                        Container(child: Icon(Icons.mail)),
                                    border: InputBorder.none,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 380),
              width: 200,
              height: 60,
              child: RaisedButton(
                color: Colors.amber,
                onPressed: () {
                  //add();
                  sendEmail(
                      name: _nomController.text,
                      email: "contact.sinamiamine@gmail.com",
                      to_email: _mailController.text,
                      subject: "Hi",
                      message: "hi");
                  add();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new LastPage(
                                      nameUser:
                                          "${_nomController.text} ${_prenomController.text}")));
                        },
                        child: Text(
                          "Valider",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
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
          ],
        ),
      ),
    );
  }
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
    content: Text(
      'Check Your Email Pour Voir La Résultat',
      style: GoogleFonts.oswald(
        color: Colors.grey,
        fontSize: 20,
      ),
    ),
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
