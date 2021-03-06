import 'package:flutter/material.dart';
import 'pages/contact_me.dart';
import 'pages/home.dart';

class Website extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cassie Frericks',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(body: HomePage()),
        '/contactMe': (context) => Scaffold(body: ContactMe()),
      }
    );
  }
}
