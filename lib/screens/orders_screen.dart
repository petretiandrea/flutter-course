import 'package:flutter/material.dart';
import 'package:flutter_course_1/providers/orders_prodiver.dart';
import 'package:flutter_course_1/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import 'package:flutter_course_1/widgets/order_item.dart' as widget;

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orders";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _orderFuture;

  @override
  void initState() {
    // in this way, future builder execute the future only one times
    // even build is called again. In this way we can show dialog or other
    // widget that call again build() method without re executing future.
    _orderFuture = Provider.of<Orders>(context, listen: false).loadOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        child: FutureBuilder(
          future: _orderFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text('Loading orders...'),
                  ],
                ),
              );
            } else if (snapshot.error != null) {
              return Center(
                child: Text("Error during loading"),
              );
            } else {
              return Consumer<Orders>(
                builder: (context, orders, child) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return widget.OrderItem(orders.orders[index]);
                    },
                    itemCount: orders.orders.length,
                  );
                },
              );
            }
          },
        ),
        onRefresh: () async =>
            await Provider.of<Orders>(context, listen: false).loadOrders(),
      ),
    );
  }
}
