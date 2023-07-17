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
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                      decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.password)),
                      validator: (value) {
                        if (value!.length < 8) {
                          return "The password is at least seven letters, Try again";
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
                            saveEmail(emailController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondPage(
                                        email: emailController.text,
                                      )),
                            );
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
}
