import 'package:flutter/material.dart';

class PicText extends StatefulWidget {
  final title;
  final text;
  final picLocation;
  final picOnLeft;

  PicText(this.title, this.text, this.picLocation, this.picOnLeft);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<PicText> {
  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).size.width > 800) {
      return Row(
        children: <Widget>[
          widget.picOnLeft ? getImage() : getDescription(),
          widget.picOnLeft ? getDescription() : getImage(),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        getImage(),
        getDescription(),
      ],
    );
  }

  Widget getImage() {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Image.asset(widget.picLocation)
    );
  }

  Widget getDescription() {
    return Flexible(
        fit: FlexFit.loose,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SelectableText(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SelectableText(widget.text)
            ],
          )
        )
    );
  }
}