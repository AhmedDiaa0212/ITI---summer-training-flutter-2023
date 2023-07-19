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
  bool isPasswordHidden = true;

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
                      //The same picture from internet
                      //Image.network('https://assets.website-files.com/60d251a34163cf29e1220806/626accd8eefaec54f23310ba_flutter%20developer%20logo.png'),
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
                      obscureText: isPasswordHidden,
                      decoration: InputDecoration(
                          labelText: "Password",
                          prefix: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.visibility,
                            ),
                            onPressed: () {
                              isPasswordHidden = !isPasswordHidden;
                              setState(() {});
                            },
                          )),
                      validator: (value) {
                        if (value!.length < 6) {
                          return "The password is short, Try again";
                        }
                        return null;
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
