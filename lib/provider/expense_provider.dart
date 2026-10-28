import 'package:flutter/material.dart';
import 'package:lilacexpensetracker/database/database_helper.dart';
import 'package:lilacexpensetracker/models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier  {
   
   List<ExpenseModel> expenses = [];

Future<void> loadExpense()async{

  expenses   = await DatabaseHelper.instance.getExpenses();
  notifyListeners();
}   

Future<void> addExpense(ExpenseModel expense)async{
  await DatabaseHelper.instance.addExpense(expense);
  await loadExpense();
}

Future<void> updateExpense(ExpenseModel expense) async {
    await DatabaseHelper.instance.updateExpense(expense);
    await loadExpense();
  }

Future<void> deleteExpense(int id) async {
await DatabaseHelper.instance.deleteExpense(id);
 await loadExpense();
  }

double get totalExpenses {
 return expenses.fold(
      0.0,
      (total, expense) => total + expense.amount,
    );
  }

}