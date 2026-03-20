import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(left: 20,right: 20),
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //section name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //section name
              Text(sectionName,style: TextStyle(color: Colors.grey.shade600),),
              //edit button
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(Icons.settings,color: Colors.grey.shade600,),
              )
            ],
          ),
          //text
          Text(text),
        ],
      ),
    );
  }
}
