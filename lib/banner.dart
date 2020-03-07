import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBanner extends StatefulWidget {
  final text;
  final showButton;
  final picLocation;

  CustomBanner(this.text, this.showButton, this.picLocation);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<CustomBanner> {
  @override
  build(context) {
    return Scaffold(
        body: Stack(
            children: <Widget>[
              new Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage(widget.picLocation),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: new Container(
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.1)
                      ),
                    ))
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: double.infinity,
                  child: bannerText()
                )
            ]
        )
    );
  }

  Widget bannerText() {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SelectableText(
            widget.text,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          widget.showButton
              ? learnMoreButton()
              : Container()
        ]
    );
  }

  Widget learnMoreButton() {
    return OutlineButton(
      onPressed: (){
        print("YAY!");
      },
      child: SelectableText("LEARN MORE", style: TextStyle(color: Colors.white, fontSize: 15)),
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(300)),
      borderSide: BorderSide(color: Colors.white, width: 3),
      highlightColor: Colors.red,
    );
  }
}