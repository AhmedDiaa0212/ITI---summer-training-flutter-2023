import 'dart:typed_data';

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
      child: Text(userEmail),
    );
  }

  getUserEmail() async {
    userEmail = await getEmail();
    setState(() {});
  }
}
