import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:i_want/screens/authentication/authenticatr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_want/screens/seller/auth/sellerSignup.dart';
import 'package:i_want/screens/seller/home/sellerHome.dart';

class sellerBankDetails extends StatefulWidget {
  final String email;
  final String nic;
  final String password;
  const sellerBankDetails({super.key,required this.email,required this.nic,required this.password});

  @override
  State<sellerBankDetails> createState() => _sellerBankDetailsState();
}

class _sellerBankDetailsState extends State<sellerBankDetails> {

    TextEditingController _accNoController=TextEditingController();
    TextEditingController _bankNameController=TextEditingController();
    TextEditingController _branchNameController=TextEditingController();

    Future<void> addUser({required String email,required String nic,required String accNo,required String bankName,required String branchName}) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return users
        .add({
          'email':email,
          'role':'SELLER',
          'name':'No User',
          'pro_pic':"",
          'acc_no':accNo,
          'bank':bankName,
          'branch':branchName

        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
    static Future<User?> signupUsingEmailPassword({required String email,required String password,required BuildContext context}) async {
    FirebaseAuth auth =FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    User?user;
    try{

      UserCredential response=await auth.createUserWithEmailAndPassword(email: email, password: password);
      user=response.user;
      print(response.user?.email);

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
    final _formkey = GlobalKey<FormState>();
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
            Form(
              key:_formkey,
              child:
            Container(child:Column(children: [
              Text("Bank Details",textAlign: TextAlign.left,style: TextStyle(fontSize: 25)),
               SizedBox(height: 40),
              Container(
                padding: EdgeInsets.fromLTRB(35,10,35,5),
                child: TextFormField(
                  controller: _accNoController,
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
                    controller: _bankNameController,
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
                  controller: _branchNameController,
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
                  
                  onPressed: () async{
                    User?user=await signupUsingEmailPassword(email:widget.email, password: widget.password,context: context);
                    if(user?.email!=null){
                      String? email=user?.email;
                      await addUser(email: widget.email,nic: widget.nic,accNo: _accNoController.text,bankName: _bankNameController.text,branchName: _branchNameController.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SellerHome()));
                    }
                  },
                  child: const Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                ),
                ),
              ],) ,
              ),
            ]),),),
          ]),
        ),
      ),
    );
  }
}