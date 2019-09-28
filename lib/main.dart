import 'dart:io';

import 'package:flutter/material.dart';

import './models/transactions.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
        fontFamily: 'OpenSans ',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontFamily: 'Quicksand', color: Colors.black),
            button:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext cnx) {
    showModalBottomSheet(
        context: cnx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Nike Air',
      amount: 199.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Adidas Cloud B2',
      amount: 154.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'Nike Air',
      amount: 199.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Adidas Cloud B2',
      amount: 154.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'Nike Air',
      amount: 199.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Adidas Cloud B2',
      amount: 154.99,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      amount: amount,
      title: title,
      date: selectedDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final kAvailableScreenSize = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    Container _chartView = Container(
      height: kAvailableScreenSize * (isLandscape ? 0.65 : 0.35),
      child: Chart(_recentTransactions),
    );
    Container _transactionList = Container(
      height: kAvailableScreenSize * (isLandscape ? 0.90 : 0.65),
      child: TransactionList(
        transactions: _userTransactions,
        txDelete: _deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _chartView,
            _transactionList,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
    );
  }
}
