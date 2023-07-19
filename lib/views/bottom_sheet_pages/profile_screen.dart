import 'package:flutter/material.dart';
import '../untils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getUserEmail();
  }

  String userEmail = "";
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.person, // Replace with the icon you want to use
          size: 100.0,
          color: Colors.blue,
        ),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            userEmail,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    ));
  }

  getUserEmail() async {
    userEmail = await getEmail();
    setState(() {});
  }
}
