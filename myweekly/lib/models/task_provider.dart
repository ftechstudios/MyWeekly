import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './db_model.dart';
import './transaction_db.dart';

class TaskData extends ChangeNotifier {
  final db = DatabaseConnect();
  List<TransactionDBTodo> _items = [];
  List<TransactionDBTodo> get items {
    return [..._items];
  }

  List _charData = [];
  List get charData {
    return [..._charData];
  }

  void addTask(TransactionDBTodo transactionDBTodo) {
    db.insertTodo(transactionDBTodo);
    fetchProducts();
    notifyListeners();
  }

  void deleteTask(TransactionDBTodo taskItem) {
    db.deleteTodo(taskItem);
    fetchProducts();
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    // final response = await db.queryTodo();
    final response = await db.getTodo();
    _items = response;
    notifyListeners();
  }

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < _items.length; i++) {
        if (_items[i].date?.day == weekDay.day &&
            _items[i].date?.month == weekDay.month &&
            _items[i].date?.year == weekDay.year) {
          totalSum += _items[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return (sum + item['amount']);
    });
  }

  get getchartList async {
    _charData = await db.getTodo();

    notifyListeners();
    return _charData;
  }

  List<Map<String, dynamic>> get groupedTransactionValuesChart {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < _charData.length; i++) {
        if (_charData[i].date?.day == weekDay.day &&
            _charData[i].date?.month == weekDay.month &&
            _charData[i].date?.year == weekDay.year) {
          totalSum += _charData[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpendingChart {
    return groupedTransactionValuesChart.fold(0.0, (sum, item) {
      return (sum + item['amount']);
    });
  }
}
