import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
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
                          
                          decoration: InputDecoration(
                            hintText: "Enter user name here.",
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
                          
                          onPressed: () {
                            
                          },
                          child: const Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                        ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          width: double.infinity,
                          child:TextButton(
                            onPressed: () {
                              
                            },
                            child: const Text('Already have an account? Login'),
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