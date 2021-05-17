import 'package:flutter/material.dart';
import 'package:flutter_course_1/model/transaction.dart';
import 'package:flutter_course_1/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

extension on DateTime {
  bool isSameDate(DateTime other) {
    return this.day == other.day &&
        this.month == other.month &&
        this.year == other.year;
  }
}

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    final today = DateTime.now();
    return List.generate(7, (index) {
      final weekDay = today.subtract(Duration(days: index));
      final totalAmount = recentTransactions
          .where((element) => element.date.isSameDate(weekDay))
          .fold(
              0.0, (previousValue, element) => previousValue + element.amount);

      return {'day': DateFormat.E().format(weekDay), 'amount': totalAmount};
    });
  }

  double get maxSpending {
    return groupedTransactionValues.fold(
        0, (previousValue, element) => previousValue + element['amount']);
  }

  Chart(this.recentTransactions);

  @override
  Widget build(BuildContext context) {
    final double totalSpent = maxSpending;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                e['day'],
                e['amount'] as double,
                totalSpent <= 0 ? 0 : (e['amount'] as double) / totalSpent,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
