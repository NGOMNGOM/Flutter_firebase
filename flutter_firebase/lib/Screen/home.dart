import "package:flutter/material.dart";
import "package:flutter_firebase/Screen/login.dart";
import "package:flutter_firebase/Screen/register.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register/Login"),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "asset/image/logo.webp",
                scale: 5,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.app_registration),
                    label: Text("Registration"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Register();
                      }));
                    },
                  )),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.login),
                    label: Text("Login"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Login();
                      }));
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
