
import 'package:flutter/material.dart';
import 'package:lilacexpensetracker/screen/homeScreen.dart';
import 'package:lilacexpensetracker/screen/addtransaction_screen.dart';
import 'package:lilacexpensetracker/screen/transactionhisScreen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() =>
      _BottomNavigationScreenState();
}

class _BottomNavigationScreenState
    extends State<BottomNavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
     Homescreen(),
     Transactionhisscreen(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF32847F),
        foregroundColor: Colors.white,
        shape:  CircleBorder(),
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (_)=> AddExpenseScreen()));
        },
        child:  Icon(Icons.add, size: 32),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF32847F),
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem(Icons.home_outlined, 0),
              navItem(Icons.history, 1),
              const SizedBox(width: 45),
              navItem(Icons.account_balance_wallet_outlined, 2),
              navItem(Icons.person_outline, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
      icon: Icon(
        icon,
        color: selectedIndex == index
            ? Colors.white
            : Colors.white70,
      ),
    );
  }
}
