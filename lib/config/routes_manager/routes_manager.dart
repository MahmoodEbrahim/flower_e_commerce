import 'package:flutter/material.dart';


abstract class Routes {
  static Route onGenerate(RouteSettings settings) {
    final url = Uri.parse(settings.name ?? '/');

    switch (url.path) {

     
      default:
        return MaterialPageRoute(
          builder: (context) =>
          const Scaffold(body: Text("No Route Page")),
        );
    }
  }
}