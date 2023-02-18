import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_provider.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  // bool _isLoading = false;
  var getTodoList = [];

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(
        () {
          // _isLoading = true;
        },
      );
      await Provider.of<TaskData>(context, listen: false).fetchProducts();
      // await Provider.of<TaskData>(context, listen: false).getchartList;
      setState(() {
        // _isLoading = false;
      });
    });
    super.initState();
    //
    // WidgetsBinding.instance.addObserver(this);
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<TaskData>(context);

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: providerData.groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'] as String,
                data['amount'] as double,
                data['amount'] == 0.0
                    ? 0.0
                    : ((data['amount'] as double) / providerData.totalSpending),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
