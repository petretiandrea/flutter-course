import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String, double, DateTime) newTransactionHandler;

  NewTransaction(this.newTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitTransactionData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    this.widget.newTransactionHandler(title, amount, _selectedDate);

    Navigator.of(context)
        .pop(); // this simulate back press (to close bottom sheet)
  }

  void _showDatePicker() {
    final dateChoose = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 2)),
    );

    dateChoose.then((date) {
      if (date == null) return;
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => _submitTransactionData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitTransactionData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No date chosen'
                        : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  TextButton(
                    child: Text('Choose date'),
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            ElevatedButton(
              child: Text('Add transaction'),
              onPressed: () => _submitTransactionData(),
            )
          ],
        ),
      ),
    );
  }
}
