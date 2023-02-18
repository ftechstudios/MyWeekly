import 'package:flutter/material.dart';
import '../models/db_model.dart';
import '../models/task_provider.dart';
import '../widgets/transaction_item.dart';
import 'package:provider/provider.dart';

class DbTransactionList extends StatelessWidget {
  const DbTransactionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: Consumer<TaskData>(
            builder: (context, taskData, child) {
              final handler = DatabaseConnect();

              return FutureBuilder<List>(
                future: handler.getTodo(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Text('Connecting to database ...');

                    case ConnectionState.done:
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, i) {
                          return TransactionItem(
                            id: snapshot.data![i].id,
                            date: snapshot.data![i].date,
                            title: snapshot.data![i].title,
                            amount: snapshot.data![i].amount,
                            //isChecked: data[i].isChecked,
                          );
                        },
                      );

                    default:
                      if (snapshot.hasError) {
                        return Text('${snapshot.hasError})');
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, i) {
                            return TransactionItem(
                              id: snapshot.data![i].id,
                              date: snapshot.data![i].date,
                              title: snapshot.data![i].title,
                              amount: snapshot.data![i].amount,
                              //isChecked: data[i].isChecked,
                            );
                          },
                        );
                      } else {
                        return const Text('No data yet');
                      }
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
