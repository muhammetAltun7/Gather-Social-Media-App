import 'package:flutter/material.dart';
import 'package:gather/pages/login_page.dart';
import 'package:gather/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //intially show login page
  bool showLoginPage=true;

  //toggle between login and register
  void togglePages() {
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    //return login page
    if(showLoginPage){
      return LoginPage(onTap: togglePages);
    }
    //return register page
    else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
