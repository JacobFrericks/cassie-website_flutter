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
    return new Column(
      children: <Widget>[
        new TextFormField(
          controller: _nameTextController,
          decoration: const InputDecoration(labelText: 'Name'),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String val) {
            _name = val;
          },
        ),
        new TextFormField(
          controller: _emailTextController,
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String val) {
            _email = val;
          },
        ),
        new TextFormField(
          controller: _messageTextController,
          decoration: const InputDecoration(labelText: 'Message'),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onSaved: (String val) {
            _message = val;
          },
        ),
        new SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed: _validateInputs,
          child: new Text('Submit'),
        )
      ],
    );
  }

  _showSnackBar() {
    var successMessage = "Thank you! We will respond to your message soon!";
    final snackbar = SnackBar(
        content: new Text(successMessage, style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
        backgroundColor: Colors.green
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void _validateInputs() {
    if (_isSubmitButtonDisabled) {
      return null;
    } else {
      setState(() =>  _isSubmitButtonDisabled = true );
    }

    _sendEmail();
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
    String postBody = '{"message": "$_message", "name": "$_name", "email": "$_email"}';
//    var response = await http.post(
//        'https://bejomkze58.execute-api.us-east-1.amazonaws.com/default/email-bobs-vending',
//        body: postBody
//    );
//    print(response.statusCode);
//    print(response.body);
    _showSnackBar();
    print("DONE");
//    if(response.statusCode >= 200 && response.statusCode < 300) {
//      _showSnackBar();
//      _clearTextFields();
//    }
    setState(() =>  _isSubmitButtonDisabled = false );
  }
}