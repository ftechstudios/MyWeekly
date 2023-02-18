import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/db_model.dart';
import '../models/task_provider.dart';
import '../widgets/adaptive_text_button.dart';
import '../models/transaction_db.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key});
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _chosenDate;
  var db = DatabaseConnect();

  // Chart chart = Chart();

  void _pickADate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        _chosenDate = datePicked;
      });
    });
  }

  // void _submitData() {
  //   if (_amountController.text.isEmpty) {
  //     return;
  //   }
  //   final enteredTitle = _textController.text;
  //   final enteredAmount = int.parse(_amountController.text);
  //
  //   if (enteredTitle.isEmpty || enteredAmount <= 0 || _chosenDate == null) {
  //     return;
  //   }
  //
  //   widget.insertTx(
  //     enteredTitle,
  //     double.parse(enteredAmount.toString()),
  //     _chosenDate,
  //   );
  //   Navigator.of(context).pop();
  // }

  void _authenticatedData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _textController.text;
    final enteredAmount = int.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _chosenDate == null) {
      return;
    }

    var myTodo = TransactionDBTodo(
      title: _textController.text,
      amount: double.parse(_amountController.text.toString()),
      date: _chosenDate,
      //isChecked: false,
    );

    // widget.insertTx(myTodo);
    Provider.of<TaskData>(context, listen: false).addTask(myTodo);

    // setState(() {});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Title'),
                onSubmitted: (_) {
                  _authenticatedData;
                },
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
                onSubmitted: (_) {
                  _authenticatedData;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _chosenDate == null
                          ? 'No date chosen'
                          : DateFormat.yMMMEd().format(_chosenDate!),
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  AdaptiveTextButton(
                    enterText: 'Choose Date',
                    onPressedFunction: _pickADate,
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _authenticatedData();
                  // print(await Provider.of<TaskData>(context, listen: false)
                  //     .chartList);
                },
                child: const Text('Add Transaction',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
