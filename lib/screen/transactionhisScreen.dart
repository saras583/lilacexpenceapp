import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lilacexpensetracker/models/expense_model.dart';
import 'package:lilacexpensetracker/provider/expense_provider.dart';
import 'package:provider/provider.dart';

class Transactionhisscreen extends StatefulWidget {
  final ExpenseModel? expense;
  const Transactionhisscreen({super.key,this.expense});

  @override
  State<Transactionhisscreen> createState() => _TransactionhisscreenState();
}

class _TransactionhisscreenState extends State<Transactionhisscreen> {
  
  @override
   


  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    
    return Scaffold(
      
      appBar: AppBar(title: Text('transactionHistory'),),
      body: SafeArea(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder( itemCount: provider.expenses.length,itemBuilder: (context,index){
                 final expense = provider.expenses[index];
              return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.receipt_long),
                  ),
                  title: Text(expense.title),
                  subtitle: Text(
                    '${expense.category} • '
                    '${expense.date.substring(0, 10)}',
                  ),
                  trailing: Text(
                    '- ₹${expense.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
            
            }),
          )
        ],
      )),
    );
  }
}