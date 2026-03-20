//return a formatted data as a string

import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timeStamp) {
  //Timestamp is the object we retrieve from firebase
  //so to display it
  DateTime dateTime = timeStamp.toDate().toLocal();
  //get year
  String year = dateTime.year.toString();

  //get month
  String month = dateTime.month.toString().padLeft(2, '0');

  //get day
  String day = dateTime.day.toString().padLeft(2, '0');

  //get hour
  String hour = dateTime.hour.toString().padLeft(2, '0');

  //get minute
  String minute = dateTime.minute.toString().padLeft(2, '0');

  //final formatted date
  String formattedDate = day + "/" + month + "/" + year + "   " + hour + ":" + minute;

  return formattedDate;
}