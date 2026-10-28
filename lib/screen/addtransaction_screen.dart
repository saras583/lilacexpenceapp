
import 'package:flutter/material.dart';
import 'package:lilacexpensetracker/provider/expense_provider.dart';
import 'package:provider/provider.dart';
import '../models/expense_model.dart';


class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  String category = 'Food';
  DateTime selectedDate = DateTime.now();
  bool isSaving = false;

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> saveExpense() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    try {
      final expense = ExpenseModel(
         
        title: titleController.text.trim(),
        amount: double.parse(amountController.text.trim()),
        category: category,
        date: selectedDate.toIso8601String(),
        description: descriptionController.text.trim().isEmpty
            ? null
            : descriptionController.text.trim(),
      );

      await context.read<ExpenseProvider>().addExpense(expense);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Expense saved successfully')),
      );

      Navigator.pop(context, true);
    } catch (e, stackTrace) {
  debugPrint('Save expense error: $e');
  debugPrintStack(stackTrace: stackTrace);

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Failed to save: $e'),
      duration: const Duration(seconds: 5),
    ),
  );
} finally {
      if (mounted) {
        setState(() => isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Expense Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Expense Title',
                    hintText: 'e.g. Lunch',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter expense title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixText: '₹ ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final amount = double.tryParse(value ?? '');

                    if (amount == null || amount <= 0) {
                      return 'Enter a valid amount greater than zero';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: category,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    'Food',
                    'Travel',
                    'Shopping',
                    'Bills',
                    'Health',
                    'Other',
                  ].map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => category = value);
                    }
                  },
                ),
                const SizedBox(height: 16),

                OutlinedButton.icon(
                  onPressed: selectDate,
                  icon: const Icon(Icons.calendar_month),
                  label: Text(
                    'Date: ${selectedDate.day}/'
                    '${selectedDate.month}/${selectedDate.year}',
                  ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isSaving ? null : saveExpense,
                    child: isSaving
                        ? const CircularProgressIndicator()
                        : const Text('Save Expense'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
