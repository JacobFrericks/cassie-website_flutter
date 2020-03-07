import 'package:flutter/material.dart';
import 'package:midiowavending_flutter/footer.dart';
import 'package:midiowavending_flutter/pictext.dart';

import '../appbar.dart';
import '../banner.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    var title1 = "One on one sessions";
    var body1 = "Need to sharpen skills during the summer? Need homework help during the school year? Tutoring available in Ankeny, Iowa! I assist with all subjects in grades K-5, and most subjects in grades 6-12 (please contact me for more information!)";
    var pic1 = "assets/self_picture.jpg";

    var title2 = "Experience";
    var body2 = "I have all the experience necessary to tutor your child! I have a Bachelor's Degree in Elementary Education. This includes 5 years of teaching experience at Ankeny Christian Academy and Riverside Elementary. I also have 4 years of tutoring experience at Huntington and private tutoring.";
    var pic2 = "assets/math_activity.jpg";
    List<Widget> homepageWidgets = <Widget>[
      banner(),
      PicText(title1, body1, pic1, true),
      PicText(title2, body2, pic2, false),
      new Footer()
    ];

    return ListView.builder (
      shrinkWrap: true,
      itemCount: homepageWidgets.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return homepageWidgets[index];
      },
    );
  }

  Widget banner() {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            new CustomBanner("Need a tutor?", false, "assets/home_banner.jpeg"),
            new CustomAppBar(),
          ],
      )
    );
  }
}