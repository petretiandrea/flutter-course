import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_course_1/model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteHandler,
  }) : super(key: key);

  final Transaction transaction;

  final void Function(String) deleteHandler;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _avatarColor;

  @override
  void initState() {
    super.initState();
    print('init state item');
    final availableColors = const [Colors.blue, Colors.purple, Colors.yellow];

    _avatarColor = availableColors[Random().nextInt(3)];
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _avatarColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(widget.transaction.date),
        ),
        trailing: mediaQuery.size.width > 360
            ? ElevatedButton.icon(
                icon: const Icon(Icons.delete),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
                onPressed: () => widget.deleteHandler(widget.transaction.id),
                label: const Text('Delete'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.deleteHandler(widget.transaction.id),
              ),
      ),
    );
  }
}
