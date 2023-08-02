import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Screen/login.dart';

import 'home.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Welcome")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  auth.currentUser!.email ?? "",
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      auth.signOut().then((value) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Home();
                        }));
                      });
                    },
                    icon: Icon(Icons.logout),
                    label: Text("Logout"))
              ],
            ),
          ),
        ));
  }
}
