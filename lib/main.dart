import 'package:flutter/material.dart';
import 'package:flutter_course_1/model/transaction.dart';
import 'package:flutter_course_1/widgets/chart.dart';
import 'package:flutter_course_1/widgets/new_transactions.dart';
import 'package:flutter_course_1/widgets/transaction_list.dart';

void main() => runApp(MaterialApp(
      title: 'Personal Expanses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Buy laptop',
    //   amount: 250.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Buy phone',
    //   amount: 400,
    //   date: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransactions {
    final last7Day = DateTime.now().subtract(Duration(days: 7));
    return _transactions
        .where((element) => element.date.isAfter(last7Day))
        .toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      _transactions.add(Transaction(
          title: title,
          amount: amount,
          date: date,
          id: DateTime.now().toString()));
    });
  }

  void _deleteTransaction(String transactionId) {
    setState(() {
      _transactions.removeWhere((element) => element.id == transactionId);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context))
        ],
      ),
      body: SingleChildScrollView(
        // scroll allow to reach every time the input box with keyboard, even in small screen
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // i can use container to wrap card and full width but this implies that all children are full width
            Chart(_recentTransactions),
            TransactionList(_transactions, _deleteTransaction)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
