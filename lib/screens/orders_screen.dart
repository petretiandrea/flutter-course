import 'package:flutter/material.dart';
import 'package:flutter_course_1/providers/orders_prodiver.dart';
import 'package:flutter_course_1/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import 'package:flutter_course_1/widgets/order_item.dart' as widget;

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return widget.OrderItem(orders.orders[index]);
        },
        itemCount: orders.orders.length,
      ),
    );
  }
}
