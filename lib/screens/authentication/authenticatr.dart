import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  static Future<User?> loginUsingEmailPassword({required String email,required String password}) async {
    FirebaseAuth auth =FirebaseAuth.instance;
    User?user;
    try{
      UserCredential userCredential=await auth.signInWithEmailAndPassword(email: email, password: password);
      user=userCredential.user;
    }on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
        print("No user found");
      }
    }
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // width: 200,
        // height:(MediaQuery.of(context).size.height),
        child:Container(
          // color: Colors.amber,
          width: 300,
          height:500,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                width: double.infinity,
                child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Proceed with your",textAlign: TextAlign.left,style: TextStyle(fontSize: 35)),
                  Text("Login",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
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
                    Container(
                      width: double.infinity,
                      alignment: Alignment.topRight,
                      child:TextButton(
                        onPressed: () {
                          
                        },
                        child: const Text('Forgot password?'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child:ElevatedButton(
                      
                      onPressed: () {
                        
                      },
                      child: const Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: double.infinity,
                      child:TextButton(
                        onPressed: () {
                          
                        },
                        child: const Text('Do you have an account? Sign up now'),
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
