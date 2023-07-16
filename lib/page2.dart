import 'package:flutter/material.dart';

import 'bottom_sheet_pages/main_screen.dart';
import 'bottom_sheet_pages/profile_screen.dart';
import 'bottom_sheet_pages/setting_screen.dart';

class SecondPage extends StatefulWidget {
  final String email;
  const SecondPage({super.key, required this.email});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int seletedIndex = 0;
  List<Widget> pages = [
    const MainScreen(),
    const SettingScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Page Two"),
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: pages[seletedIndex],
        /*Center(
          child: Text(
            "Hi ${widget.email} ,Welcome to my application",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 20.0),
          ),
        ),*/
        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "settings"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "profile")
            ],
            onTap: (pageIndex) {
              seletedIndex = pageIndex;
              setState(
                  () {}); //rebuild the widget with new selected index value
            }));
  }
}
