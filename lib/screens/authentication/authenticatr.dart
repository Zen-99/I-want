import "package:flutter/material.dart";

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
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
          height:300,
          child: Column(
            children: [
              Text("Login"),
              Form(
                key:_formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                    ),
                     SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                      child: const Text('Login'),
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
