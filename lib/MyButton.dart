import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String lable;
  const MyButton({super.key, required this.lable});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Text(
        widget.lable,
        style: const TextStyle(color: Colors.white),
      )),
    );
  }
}
