import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Tab'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Welcome to the Home Tab!'),
      ),
    );
  }
}