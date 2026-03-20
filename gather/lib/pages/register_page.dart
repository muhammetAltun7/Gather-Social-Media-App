import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gather/components/my_button.dart';
import 'package:gather/components/my_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //textfield controllers
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController confirmPasswordController=TextEditingController();

  //dispose the controllers for memory management
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // create an account
  void createAccount() async {
    //show loading circle
    showDialog(context: context, builder: (context)=>const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 3,
      ),
    ));
    //make sure passwords match
    if(passwordController.text.trim()!=confirmPasswordController.text.trim()){
      //pop loading circle
      Navigator.pop(context);
      //show error to user
      displayMessage("Passwords do not match!");
      return;
    }
    //try creating the user
    try {
      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
      );
      //after creating the user, create a new document in the cloud firestore called "Users"
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        "username":emailController.text.trim().split("@")[0], //initial user name
        "bio":"empty bio", //initial empty bio
        //add whatever u want
      });
      //pop loading circle
      if (mounted && Navigator.canPop(context)) Navigator.pop(context);
    } on FirebaseAuthException catch(e){
      //pop loading circle
      if (mounted && Navigator.canPop(context)) Navigator.pop(context);
      //show error to user
      displayMessage(e.code);
    }
  }

  //display a dialog message
  void displayMessage(String message) {
    showDialog(context: context, builder: (context)=>AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Icon(Icons.warning_amber,color: Colors.red,),
      content: Text("${message}",textAlign: TextAlign.center,style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),),
    ));
  }


  @override
  Widget build(BuildContext context) {
    //device sized with media query
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Gather",style: GoogleFonts.aBeeZee(
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Image.asset("lib/assets/logo.png",width: screenWidth*0.25,),
              SizedBox(height: screenHeight*0.05,),
              //let's create an account text
              Container(
                  width: screenWidth*0.8,
                  child: Text("Let's create an account!",style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700
                  ),textAlign: TextAlign.center,)
              ),
              SizedBox(height: screenHeight*0.05,),
              // email textfield
              MyTextField(
                  controller: emailController,
                  obscureText: false,
                  labelText: "Email",
              ),
              SizedBox(height: screenHeight*0.01,),
              // password textfield
              MyTextField(
                  controller: passwordController,
                  obscureText: true,
                  labelText: "Password",
              ),
              SizedBox(height: screenHeight*0.01,),
              //confirm password textfield
              MyTextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  labelText: "Confirm password",
              ),
              SizedBox(height: screenHeight*0.04,),
              //sign up button
              MyButton(
                  text: "Sign Up",
                  onTap: (){
                    createAccount();
                  }
              ),
              SizedBox(height: screenHeight*0.01,),
              //already a member , register now text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a member?"),
                  SizedBox(width: screenWidth*0.02,),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    onPressed: widget.onTap,
                    child: Text("Login now",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

  }
}
