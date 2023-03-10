import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/login_page.dart';
import 'package:first_app/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  //AuthController.instance..
  static AuthController instance = Get.find();
  //email,password,name...
   late Rx<User?> _user;
   FirebaseAuth auth = FirebaseAuth.instance;

   @override
  void onReady() {
     super.onReady();
     _user = Rx<User?>(auth.currentUser);
     //our user would be notified
     _user.bindStream(auth.userChanges());
     ever(_user, _initialScreen);
   }


   _initialScreen(User? user){
     if(user==null){
       print("login page");
       Get.offAll(()=>LoginPage());
     }else{
       Get.offAll(()=>WelcomePage());
     }
   }

   void register(String email, password)async{
     try{
     await  auth.createUserWithEmailAndPassword(email: email, password: password);
     }catch(e) {
       Get.snackbar("About User", "User message",
       backgroundColor: Colors.redAccent,
       snackPosition: SnackPosition.BOTTOM,
         titleText: Text(
           "Acounnt creation failed",
           style: TextStyle(
             color: Colors.white,
           ),
         ),
         messageText: Text(
           e.toString()

         )
       );





     }
   }

}


