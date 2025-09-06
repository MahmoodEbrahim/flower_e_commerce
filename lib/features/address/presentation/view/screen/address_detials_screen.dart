import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_txt_field_widget.dart';
import 'package:flutter/material.dart';

class AddressDetialsScreen extends StatelessWidget {
  const AddressDetialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(

        leading: IconButton(onPressed: ()=>Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Column(
        children: [
CustomTxtFieldWidget(lbl: "Enter ", hint: "")
        ],
      ),
    );
  }
}
