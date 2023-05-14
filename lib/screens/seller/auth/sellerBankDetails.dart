import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:i_want/screens/seller/auth/sellerSignup.dart';

class sellerBankDetails extends StatefulWidget {
  const sellerBankDetails({super.key});

  @override
  State<sellerBankDetails> createState() => _sellerBankDetailsState();
}

class _sellerBankDetailsState extends State<sellerBankDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // width: 200,
        // height:(MediaQuery.of(context).size.height),
        child:Container(
          // color: Colors.amber,
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10,10,10,10),
          height:750,
          child: Column(children: [

            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(35,50,35,20),  
              child:Column(children: [
                Text("Create new account.",textAlign: TextAlign.left,style: TextStyle(fontSize: 35)),
                Text("Sign up",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
              ],)
            
            ),
            SizedBox(height: 40),
            Container(child:Column(children: [
              Text("Bank Details",textAlign: TextAlign.left,style: TextStyle(fontSize: 25)),
               SizedBox(height: 40),
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
              ),
              SizedBox(height: 40,),
              Container(
                // color: Colors.amber,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(45,5,20,5),
                child:Row(children: [
                Container(
                  width: 150,
                  height: 50,
                  child:ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white,foregroundColor: Colors.blue),
                  onPressed: () {
                     Navigator.push(context,MaterialPageRoute(builder: (context) => const SellerSignup()));
                  },
                  child: const Text('Back',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 150,
                  height: 50,
                  child:ElevatedButton(
                  
                  onPressed: () {
                  
                  },
                  child: const Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                ),
                ),
              ],) ,
              ),
            ]),),
          ]),
        ),
      ),
    );
  }
}