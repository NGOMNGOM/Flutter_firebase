import 'package:flutter/material.dart';
import 'package:flutter_firebase/Model/profile.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var formKey = GlobalKey<FormState>();
  var profile = Profile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email"),
                    onSaved: (String? email) {
                      profile.email = email;
                    },
                    validator: (String? email) {
                      if (email!.isEmpty) {
                        return "Please Input";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password"),
                      onSaved: (String? password) {
                        profile.pwd = password;
                      },
                      validator: (String? pwd) {
                        if (pwd!.isEmpty) {
                          return "Please Input";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();
                              formKey.currentState?.reset();
                              print(
                                  "Email = ${profile.email}, password = ${profile.pwd}");
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 20),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
