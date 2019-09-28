import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function txDelete;

  const TransactionList({this.transactions, this.txDelete});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, contraints) {
            return Column(
              children: <Widget>[
                Container(
                  width: contraints.maxWidth * (isLandscape ? 0.5 : 0.7),
                  height: contraints.maxHeight * (isLandscape ? 0.7 : 0.1),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'There is no transactions yet.',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  height: contraints.maxHeight * 0.3,
                  child: !isLandscape
                      ? Image.asset(
                          'assets/images/zzz.png',
                          fit: BoxFit.contain,
                        )
                      : null,
                ),
              ],
            );
          })
        : ListView.builder(
            // has an infinite height

            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 33,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: FittedBox(
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 500
                      ? FlatButton.icon(
                          onPressed: () => txDelete(transactions[index].id),
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () => txDelete(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
