import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  final String txt1;
  final String txt2;
  final TextStyle? style1;
  final TextStyle? style2;
  const TextSection({super.key, required this.txt1, required this.txt2, this.style1, this.style2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(txt1,style: style1,), Text(txt2,style: style2,)],
      ),
    );
  }
}
