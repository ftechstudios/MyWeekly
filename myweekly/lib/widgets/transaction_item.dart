import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/task_provider.dart';
import '../models/transaction_db.dart';
import '../models/db_model.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    //required this.isChecked,
  }) : super(key: key);

  final int id;
  final String title;
  final double amount;
  final DateTime date;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  var db = DatabaseConnect();

  @override
  void initState() {
    // const availableColors = [
    //   // Colors.black,
    //   // Colors.grey,
    //   Color(0xff000088),
    // ];

    // _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  // #002C75,
  // Color(0xff790000),
  @override
  Widget build(BuildContext context) {
    var anotherTodo = TransactionDBTodo(
      id: widget.id,
      title: widget.title,
      amount: widget.amount,
      date: widget.date,
      // isChecked = widget.isChecked,
    );

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: const Color(0xff000088),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                '\$${widget.amount}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title:
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(
          DateFormat.yMMMEd().format(widget.date),
          style: const TextStyle(
              // fontSize: 14,
              // color: Colors.blueGrey,
              ),
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton.icon(
                onPressed: () {
                  Provider.of<TaskData>(context, listen: false)
                      .deleteTask(anotherTodo);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Provider.of<TaskData>(context, listen: false)
                      .deleteTask(anotherTodo);
                },
              ),
      ),
    );
  }
}
