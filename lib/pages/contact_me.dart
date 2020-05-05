import 'dart:convert';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../appbar.dart';
import '../banner.dart';


class ContactMe extends StatefulWidget {
  ContactMe({Key key}) : super(key: key);

  @override
  _ContactMeState createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _name;
  String _email;
  String _message;
  final TextEditingController _nameTextController = new TextEditingController();
  final TextEditingController _emailTextController = new TextEditingController();
  final TextEditingController _messageTextController = new TextEditingController();
  bool _isSubmitButtonDisabled;

  @override
  void initState() {
    _isSubmitButtonDisabled = false;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> contactMeWidgets = <Widget>[
      banner(),
      new Container(
        margin: new EdgeInsets.all(15.0),
        child: new Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: FormUI(),
        ),
      ),
    ];

    return ListView.builder (
        shrinkWrap: true,
        itemCount: contactMeWidgets.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return contactMeWidgets[index];
        },
    );
  }

  Widget banner() {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            new CustomBanner("Contact Me", false, "assets/child_handwriting.jpeg"),
            new CustomAppBar(),
          ],
        )
    );
  }

  Widget FormUI() {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 150.0,),
              //input field for email
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: validateName,
                onSaved: (value) => _name = value,
              ),
              //input field for password
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: validateEmail,
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Message'),
                onSaved: (value) => _message = value,
              ),
              RaisedButton(
                child: Text ('Submit', style: TextStyle(fontSize: 20.0),),
                onPressed: _validateInputs,

              )
            ]
    );
  }

  _showSnackBar(String message, bool success) {
    Color backgroundColor;
    if (success) {
      backgroundColor = Colors.green;
    } else {
      backgroundColor = Colors.red;
    }
    final snackbar = SnackBar(
        content: new Text(message, style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
        backgroundColor: backgroundColor
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  String validateName(String value) {
    if (value == null || value.length < 3)
      return 'Name must be more than 2 charaters';
    else
      if (value == null) {
        print("FAILED");
        return "Not a valid input";
      }
      print("SUCCESS");
      _name = value;
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      if (value == null) {
        return "Not a valid input";
      }
      _email = value;
      return null;
  }

  void _validateInputs() async {
    final form = _formKey.currentState;
    if(form.validate()) {
      _formKey.currentState.save();
      _sendEmail();
    }

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _clearTextFields() {
    _nameTextController.clear();
    _emailTextController.clear();
    _messageTextController.clear();
  }

  void _sendEmail() async {
    String postBody = json.encode({"to": "cassie_tutoring", "message": _message, "name": _name, "email": _email});
    print(postBody);
    print("Attempting post...");
    var response = await http.post(
        'https://236hz4fdx4.execute-api.us-east-1.amazonaws.com/default/email_function',
        body: postBody
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode < 300) {
      _showSnackBar("Thank you! We will respond to your message soon!", true);
      _clearTextFields();
    } else {
      _showSnackBar("An error occurred! Please try again later.", false);
      print(response);
    }
    setState(() =>  _isSubmitButtonDisabled = false );
  }
}