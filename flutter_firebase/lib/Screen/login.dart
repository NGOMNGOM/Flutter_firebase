import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Model/profile.dart';
import 'package:flutter_firebase/Screen/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();
  var profile = Profile(email: "", pwd: "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                appBar: AppBar(title: Text("Error")),
                body: Center(child: Text("${snapshot.error}")));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Login"),
                ),
                body: Container(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  TextFormField(
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "Please Input"),
                                      EmailValidator(
                                          errorText: "Wrong Email Format")
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration:
                                        InputDecoration(label: Text("Email")),
                                    onSaved: (String? value) {
                                      profile.email = value ?? "";
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Password",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    validator: RequiredValidator(
                                        errorText: "Please Input"),
                                    decoration: InputDecoration(
                                        label: Text("Password")),
                                    onSaved: (String? value) {
                                      profile.pwd = value ?? "";
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState?.save();
                                            try {
                                              print(
                                                  "${profile.email}, ${profile.pwd}");
                                              await FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: profile.email,
                                                      password: profile.pwd)
                                                  .then((value) {
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return UserScreen();
                                                }));
                                              });
                                            } on FirebaseException catch (e) {
                                              String noti = "";
                                              if (e.code == "user-not-found") {
                                                noti = "No account";
                                              } else if (e.code ==
                                                  "wrong-password") {
                                                noti = "Wrong password";
                                              }
                                              Fluttertoast.showToast(
                                                  msg: noti,
                                                  gravity: ToastGravity.CENTER);
                                            }
                                          }
                                        },
                                        child: Text("Login")),
                                  )
                                ]))))));
          }
          return Scaffold(
              appBar: AppBar(title: Text("Login")),
              body: Center(child: const CircularProgressIndicator()));
        }));
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Login"),
    //   ),
    //   body: Text("Login Screen"),
    // );
  }
}
