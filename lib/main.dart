import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lilacexpensetracker/provider/expense_provider.dart';
import 'package:lilacexpensetracker/screen/bottomnavigation_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(create: (_)=> ExpenseProvider(),child: Myapp(),)
  );
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
    home: BottomNavigationScreen(),);
  }
}