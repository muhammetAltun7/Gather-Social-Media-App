import 'package:flutter/material.dart';

class MyPostTextField extends StatelessWidget {
  //textfield attributtes
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  const MyPostTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.hintText,
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
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade200,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
