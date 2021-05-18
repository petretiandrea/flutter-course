import 'package:flutter/material.dart';
import 'package:flutter_course_1/model/transaction.dart';
import 'package:flutter_course_1/widgets/transaction_item.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) deleteHandler;

  TransactionList(this.transactions, this.deleteHandler);

  @override
  Widget build(BuildContext context) {
    print('build() transaction list');
    final mediaQuery = MediaQuery.of(context);
    return Container(
        height: mediaQuery.size.height * 0.62,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, contraints) {
                return Column(
                  children: [
                    Text(
                      'No Transactions added yet!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: contraints.maxHeight * 0.5,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              })
            : ListView(
                children: transactions
                    .map((transaction) => TransactionItem(
                          key: ValueKey(transaction.id),
                          transaction: transaction,
                          deleteHandler: deleteHandler,
                        ))
                    .toList(),
              ));
  }
}
