class TransactionDBTodo {
  final int? id;
  final String? title;
  final double amount;
  final DateTime? date;
  // final bool isChecked;

  TransactionDBTodo({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    //required this.isChecked,
  });

  TransactionDBTodo.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        amount = res["amount"],
        date = DateTime.parse(res["date"]);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toString(),
    };
  }

  @override
  String toString() {
    return 'Transaction(id: $id, title: $title, amount: $amount, date: $date';
  }
}
