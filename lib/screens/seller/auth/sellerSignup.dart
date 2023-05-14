import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:email_validator/email_validator.dart';
import 'package:i_want/screens/authentication/authenticatr.dart';
import 'package:i_want/screens/seller/auth/sellerBankDetails.dart';

class SellerSignup extends StatefulWidget {
  const SellerSignup({super.key});

  @override
  State<SellerSignup> createState() => _SellerSignupState();
}

class _SellerSignupState extends State<SellerSignup> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nicController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool validateNIC(String nic) {
    RegExp nicPattern = RegExp(r'^\d{9}[vVxX]$');

    if (!nicPattern.hasMatch(nic)) {
      return false;
    }
    int birthYear = int.parse(nic.substring(0, 2));
    if (birthYear > 0 && birthYear < 22) {
      birthYear += 2000;
    } else {
      birthYear += 1900;
    }
    int birthDay = int.parse(nic.substring(2, 5));
    if (birthDay > 0 && birthDay < 367) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    return Scaffold(
        body: Center(
      child: Container(
        height: 750,
        // color: Colors.amber,
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(35, 50, 35, 20),
                        child: Column(
                          children: [
                            Text("Create new account.",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 35)),
                            Text("Sign up",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35)),
                          ],
                        )),
                  ],
                )),
            SizedBox(height: 40),
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(35, 20, 35, 10),
                      child: TextFormField(
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
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(35, 0, 35, 5),
                      child: TextFormField(
                        controller: _nicController,
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
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
                      child: TextFormField(
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
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
                      child: TextFormField(
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
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          bool isValidEmail =
                              EmailValidator.validate(_emailController.text);
                          if (!isValidEmail) {
                            print("Email invalid!");
                          } else if (!validateNIC(_nicController.text)) {
                            print("Nic is wrong");
                          } else if (_confirmPasswordController.text !=
                              _passwordController.text) {
                            print("password Confirmation wrong");
                          } else if (_passwordController.text.length < 8) {
                            print(
                                "password length should be atlease 8 characters");
                          } else {
                            String? emailT = _emailController.text;
                            String? nicT = _nicController.text;
                            String? passwordT = _passwordController.text;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        sellerBankDetails(
                                            email: emailT,
                                            nic: nicT,
                                            password: passwordT)));
                          }
                        },
                        child: const Text('Next',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const Authenticate()));
                        },
                        child: const Text('Already have an account? Login'),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
