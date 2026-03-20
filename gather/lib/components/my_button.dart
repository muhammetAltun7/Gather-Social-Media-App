import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  //button attributtes
  final Function()? onTap;
  final String text;
  const MyButton({
    super.key,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    //device sized with media query
    var screenWidth=MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth*0.8,
      child: ElevatedButton(
          onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(text,style: TextStyle(fontWeight: FontWeight.bold),),
          ),
      ),
    );
  }
}
