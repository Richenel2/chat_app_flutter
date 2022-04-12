import 'package:flutter/material.dart';
import 'package:sms/constantes/theme.dart';

class CustomTextInput extends StatelessWidget {
  final String text;
  const CustomTextInput({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: MyColor.primaryGray.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        )
      ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(labelText: text),
        ),
      ),
    );
  }
}
