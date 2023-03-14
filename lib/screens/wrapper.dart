import 'package:flutter/material.dart';
import 'package:i_want/screens/authentication/authenticatr.dart';
import 'package:i_want/screens/seller/home/sellerHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp =await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            return Authenticate();
          }else{
            return const Center(
              child:CircularProgressIndicator(),
            );
          }
        },),
      );
  }
}