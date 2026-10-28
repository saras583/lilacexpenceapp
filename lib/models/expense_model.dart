class ExpenseModel {

  int? id;
  final String title;
  final double amount;
  final String category;
  final String date;
   final String? description;

ExpenseModel({
     this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.description
   });

Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date,
      'description': description,
    };
  }
 factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      date: map['date'] as String,
      description: map['description'] as String?,
    );
  }

  
}