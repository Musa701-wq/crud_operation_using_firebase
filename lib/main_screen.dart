import 'package:crrud_operations/view/add_to_do.dart';
import 'package:crrud_operations/view/home_screen.dart';
import 'package:crrud_operations/view/login_screen.dart';
import 'package:crrud_operations/view/profile_screen.dart' show profile_screen;
import 'package:flutter/material.dart';
import 'View/add_user.dart';
import 'widgets/custom_navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(), // Home
    create_todo(), // Add User Screen
    profile_screen(),  // Profile Screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
