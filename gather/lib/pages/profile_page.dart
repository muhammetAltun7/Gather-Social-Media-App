import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gather/components/my_text_box.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //get the current user
  final currentUser=FirebaseAuth.instance.currentUser!;
  //all users
  final usersColelction=FirebaseFirestore.instance.collection("Users");

  //edit field
  Future<void> editField(String field) async {
    String newValue="";
    await showDialog(context: context, builder: (context)=>AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text("Edit "+field,style: TextStyle(color: Colors.black),),
      content: TextField(
        autofocus: true,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: "Enter new ${field}",
          hintStyle: TextStyle(color: Colors.grey.shade600),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade600),
          )
        ),
        onChanged: (value) {
          newValue=value;
        },
      ),
      actions: [
        //cancel buttons
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel",style: TextStyle(color: Colors.black),),
        ),
        //save button
        TextButton(
          onPressed: () => Navigator.of(context).pop(newValue),
          child: Text("Save",style: TextStyle(color: Colors.black),),
        ),
      ],
    ));
    //update in firestore
    if(newValue.trim().length>0){
      //only update if there is something in the textfield
      await usersColelction.doc(currentUser.email).update({field:newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    //device sizes with media query
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        //go back to home page
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
          //back arrow icon
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        // Profile Text
        title: Text("My Profile",style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
          builder: (context,snapshot){
            //get user data
            if(snapshot.hasData){
              final userData=snapshot.data!.data() as Map<String,dynamic>;
              return ListView(
                children: [
                  SizedBox(height: screenHeight*0.1,),
                  //profile picture
                  Icon(Icons.person,size: screenWidth*0.2,),
                  SizedBox(height: screenHeight*0.02,),
                  //user email
                  Text("${currentUser.email}",textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: screenHeight*0.02,),
                  //user details
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text("My Details",style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),),
                  ),
                  SizedBox(height: screenHeight*0.02,),
                  //username
                  MyTextBox(text: userData["username"], sectionName: "username",onPressed: ()=>editField("username")),
                  SizedBox(height: screenHeight*0.01,),
                  //bio
                  MyTextBox(text: userData["bio"], sectionName: "bio",onPressed: ()=>editField("bio")),
                  SizedBox(height: screenHeight*0.04,),
                ],
              );
            }else if(snapshot.hasError) {
              return Center(child: Text("Error"+snapshot.error.toString()),);
            }
            return const Center(
              child: CircularProgressIndicator(color: Colors.white12,strokeWidth: 3,),
            );
          }
      )
    );
  }
}
