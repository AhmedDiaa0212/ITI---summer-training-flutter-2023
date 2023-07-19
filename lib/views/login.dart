import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/views/MyButton.dart';
import 'package:newapp/views/page2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetOne extends StatefulWidget {
  const WidgetOne({super.key});

  @override
  State<WidgetOne> createState() => _WidgetOneState();
}

class _WidgetOneState extends State<WidgetOne> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController =
      TextEditingController(text: "Hi");
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: ListView(children: [
              Column(children: [
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset("assets/flutterpic.jpg"),
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value!.contains('@')) {
                          return null;
                        } else {
                          return "The email is not valid , Try again";
                        }
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.password)),
                      validator: (value) {
                        if (value!.length < 7) {
                          return "The password is at least 8 letters, Try again";
                        } else {
                          return null;
                        }
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            signinUsingFirebase(
                                emailController.text, passwordController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondPage(
                                        email: emailController.text,
                                      )),
                            );
                          } else {
                            emailController.clear();
                          }
                        },
                        child: const MyButton(
                          lable: 'login',
                        ))),
                const Text('Forgot password?  No yawa. Tap me'),
                const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: MyButton(
                      lable: 'No Account? Sign Up',
                    ))
              ])
            ])));
  }

  saveEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  signinUsingFirebase(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    print(user?.uid);
    saveEmail(user!.email!);
  }
}
