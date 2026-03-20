import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gather/components/my_button.dart';
import 'package:gather/components/my_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //textfield controllers
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  //dispose the controllers for memory management
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //sign user in
  void signIn() async {
    //show loading circle
    showDialog(
        context: context,
        barrierDismissible:false,
        builder: (context)=>const Center(
      child: CircularProgressIndicator(color: Colors.white,strokeWidth: 3,),)
    );
    //try sign in
    try{
     await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: emailController.text.trim(),
         password: passwordController.text.trim(),
     );
     //pop loading circle
     if (mounted && Navigator.canPop(context)) Navigator.pop(context);
    }
    //catch any errors
    on FirebaseAuthException catch(e){
      //pop loading circle
      if (mounted && Navigator.canPop(context)) Navigator.pop(context);
      //display error messages
      displayMessage("${e.code}");
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

  //show password
  bool showPassword=false;

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
              //welcome back text
              Container(
                  width: screenWidth*0.8,
                  child: Text("Welcome back, you've been missed!",style: TextStyle(
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
              SizedBox(height: screenHeight*0.04,),
              //sign in button
              MyButton(
                  text: "Sign In",
                  onTap: signIn,
              ),
              SizedBox(height: screenHeight*0.01,),
              //not a member , register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?"),
                 SizedBox(width: screenWidth*0.02,),
                  TextButton(
                   style: TextButton.styleFrom(
                     backgroundColor: Colors.grey.shade300,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15),
                     )
                   ),
                   onPressed: widget.onTap,
                     child: Text("Register now",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
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
