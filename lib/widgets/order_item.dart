import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_course_1/providers/orders_prodiver.dart' as provider;

class OrderItem extends StatefulWidget {
  final provider.OrderItem item;

  OrderItem(this.item);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expandend = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height:
          _expandend ? min(widget.item.products.length * 20.0 + 110, 200) : 92,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.item.amount}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.item.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expandend ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expandend = !_expandend;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expandend
                  ? min(widget.item.products.length * 20.0 + 14, 180)
                  : 0,
              child: ListView(
                children: widget.item.products
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${e.quantity}x \$${e.price}',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
