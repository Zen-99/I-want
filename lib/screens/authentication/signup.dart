import 'dart:math';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:i_want/screens/authentication/authenticatr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_want/screens/home/home.dart';
import 'package:i_want/screens/seller/auth/sellerSignup.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _confirmPasswordController=TextEditingController();

  Future<void> addUser({required String email}) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return users
        .add({
          'email':email,
          'role':'BUYER',
          'name':"No Name",
          'pro_pic':""
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<User?> signupUsingEmailPassword({required String email,required String password,required String confirmPassword,required BuildContext context}) async {
    FirebaseAuth auth =FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    User?user;
    try{
      if(password!=confirmPassword){
        print("Password doesn't match");
      }else{
        UserCredential response=await auth.createUserWithEmailAndPassword(email: email, password: password);
        user=response.user;
        print(response.user?.email);
      }
    }on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
        print("No user found");
      }else{
        print(e.code);
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: Center(
            child:Container(
              // color: Colors.amber,
              width: 300,
              height:600,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: double.infinity,
                    child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Create new account.",textAlign: TextAlign.left,style: TextStyle(fontSize: 35)),
                      Text("Sign up",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
                    ],
                  )),
                  
                  SizedBox(height: 40),
                  Form(
                    key:_formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Enter email here.",
                            focusColor: Colors.blueGrey,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.blue), //<-- SEE HERE
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3, color: Colors.blue), //<-- SEE HERE
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: "Enter password here.",
                            focusColor: Colors.blueGrey,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.blue), //<-- SEE HERE
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3, color: Colors.blue), //<-- SEE HERE
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: "Confirm password here.",
                            focusColor: Colors.blueGrey,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.blue), //<-- SEE HERE
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3, color: Colors.blue), //<-- SEE HERE
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 50),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child:ElevatedButton(
                          
                            onPressed: () async{
                              User?user=await signupUsingEmailPassword(email:_emailController.text, password: _passwordController.text,confirmPassword:_confirmPasswordController.text,context: context);
                              if(user?.email!=null){
                                String? email=user?.email;
                                await addUser(email: email.toString());
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
                              }
                            },
                            child: const Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          width: double.infinity,
                          child:TextButton(
                            onPressed: () {
                               Navigator.push(context,MaterialPageRoute(builder: (context) => const Authenticate()));
                            },
                            child: const Text('Already have an account? Login'),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          child:TextButton(
                            onPressed: () {
                               Navigator.push(context,MaterialPageRoute(builder: (context) => const SellerSignup()));
                            },
                            child: const Text('I want to become a seller'),
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),

          )
        );
  }
}