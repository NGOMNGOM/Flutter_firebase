import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Model/profile.dart';
import 'package:flutter_firebase/Screen/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var formKey = GlobalKey<FormState>();
  var profile = Profile(email: "", pwd: "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                appBar: AppBar(title: Text("Error")),
                body: Center(child: Text("${snapshot.error}")));
          }
          if (snapshot.connectionState == ConnectionState.done) {
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
                              profile.email = email ?? "";
                            },
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Please Input Email"),
                              EmailValidator(errorText: "Wrong Email Format")
                            ]),
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
                              decoration:
                                  InputDecoration(labelText: "Password"),
                              onSaved: (String? password) {
                                profile.pwd = password ?? "";
                              },
                              validator: RequiredValidator(
                                  errorText: "Please Input Password")),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    // ต้องเป็น async + await เพราะว่าต้องรอการลงทะเบียนให้เสร็จ
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState?.save();

                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: profile.email,
                                                password: profile.pwd)
                                            .then((value) {
                                          Fluttertoast.showToast(
                                              msg: "Register complete!",
                                              gravity: ToastGravity.CENTER);
                                          formKey.currentState?.reset();
                                          // ignore: use_build_context_synchronously
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const Home();
                                          }));
                                        });

                                        // Navigator.pop(context);
                                      } on FirebaseAuthException catch (e) {
                                        // มีสอง error email ซ้ำ หรือ รหัสสั้น
                                        print(e.code);
                                        Fluttertoast.showToast(
                                            msg: e.message ?? "",
                                            gravity: ToastGravity.CENTER);
                                      }
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

          return Scaffold(
              appBar: AppBar(title: Text("Register")),
              body: Center(child: const CircularProgressIndicator()));
        });
    //
  }
}
