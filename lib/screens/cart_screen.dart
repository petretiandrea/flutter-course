import 'package:flutter/material.dart';
import 'package:flutter_course_1/providers/cart_prodiver.dart';
import 'package:flutter_course_1/providers/orders_prodiver.dart';
import 'package:provider/provider.dart';

import 'package:flutter_course_1/widgets/cart_item.dart' as cart_item_widget;

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) => Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    OrderButton(
                      cart: cart,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => cart_item_widget.CartItem(
                    cart.items.values.toList()[index]),
                itemCount: cart.items.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;

  const OrderButton({Key key, @required this.cart}) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  void _sendOrder() async {
    setState(() => _isLoading = true);
    try {
      await Provider.of<Orders>(context, listen: false).addOrder(
        widget.cart.items.values.toList(),
        widget.cart.totalAmount,
      );
      widget.cart.clear();
    } catch (error) {} finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading ? CircularProgressIndicator() : Text('Order Now'),
      onPressed: widget.cart.totalAmount <= 0 ? null : _sendOrder,
    );
  }
}
