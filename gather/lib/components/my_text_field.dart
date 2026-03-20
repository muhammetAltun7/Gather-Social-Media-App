import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  //textfield attributtes
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    //device sized with media query
    var screenWidth=MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth*0.8,
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }
}
