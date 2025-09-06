import 'package:flutter/material.dart';

class CartTab extends StatelessWidget{
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Tab'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Welcome to the Cart Tab!'),
      ),
    );
  }
}