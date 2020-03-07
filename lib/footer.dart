import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  Footer();

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          contactMeButton(),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
        ]
    );
  }

  Widget contactMeButton() {
    return FlatButton(
      color: Color.fromRGBO(0, 128, 128, 1),
      textColor: Colors.white,
      padding: EdgeInsets.all(8.0),
      onPressed: () {
        print("Contact Me Pressed!");
      },
      child: Text(
        "CONTACT ME",
        style: TextStyle(fontSize: 15.0),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
      ),

    );
  }
}