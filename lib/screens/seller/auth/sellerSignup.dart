import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SellerSignup extends StatefulWidget {
  const SellerSignup({super.key});

  @override
  State<SellerSignup> createState() => _SellerSignupState();
}

class _SellerSignupState extends State<SellerSignup> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    return Scaffold(
          body: Center(
            child:SingleChildScrollView(
              // color: Colors.amber,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: double.infinity,
                    child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(35,50,35,20),  
                        child:Column(children: [
                          Text("Create new account.",textAlign: TextAlign.left,style: TextStyle(fontSize: 35)),
                          Text("Sign up",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
                        ],)
                      
                      ),

                    ],
                  )),
                  
                  SizedBox(height: 40),
                  Form(
                    key:_formkey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(35,20,35,10),  
                          child: TextFormField(
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
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.fromLTRB(35,0,35,5),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter NIC here.",
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
                        ),
                        SizedBox(height: 30),
                        Container(child:Column(children: [
                          Text("Bank Details",textAlign: TextAlign.left,style: TextStyle(fontSize: 25)),
                          Container(
                            padding: EdgeInsets.fromLTRB(35,10,35,5),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Account No",
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
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(35,5,35,5),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Bank Name",
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
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(35,5,35,5),
                              child:TextFormField(
                              decoration: InputDecoration(
                                hintText: "Branch Name",
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
                          )
                        ]),),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.fromLTRB(35,5,35,5),
                          child: TextFormField(
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
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.fromLTRB(35,5,35,5),
                          child:TextFormField(
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
                        ),),
                        SizedBox(height: 50),
                        Container(
                          width: 200,
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
                        SizedBox(height: 50),
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