import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/ui/auth/login_screen.dart';
import 'package:untitled1/ui/auth/signup_screen.dart';

import '../ui/firebase_database/post_screen.dart';


class SplashServices{

  Future<void> isLogin(BuildContext context) async {

    FirebaseAuth auth = FirebaseAuth.instance;

    final user =  auth.currentUser ;

    if(user != null){
       
      Timer(const Duration(seconds: 2),
              ()=> Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) =>  PostScreen()),
              (route) => false));
    }else {
      Timer(const Duration(seconds: 2),
              ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignUpScreen()),(route)=>false)
      );
    }


  }
}