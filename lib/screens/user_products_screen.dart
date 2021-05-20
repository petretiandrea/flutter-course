import 'package:flutter/material.dart';
import 'package:flutter_course_1/providers/products_provider.dart';
import 'package:flutter_course_1/screens/edit_product_screen.dart';
import 'package:flutter_course_1/widgets/app_drawer.dart';
import 'package:flutter_course_1/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user-products";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final messanger = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            await Provider.of<ProductsProvider>(context, listen: false)
                .loadProducts(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: productsData.products.length,
              itemBuilder: (context, index) => Column(
                    children: [
                      UserProductItem(
                        productsData.products[index].id,
                        productsData.products[index].title,
                        productsData.products[index].imageUrl,
                        deleteHandler: () {
                          productsData
                              .deleteProduct(
                                productsData.products[index].id,
                              )
                              .catchError(
                                (_) => messanger.showSnackBar(
                                  SnackBar(
                                    content: Text('Deleting failed!'),
                                  ),
                                ),
                              );
                        },
                      ),
                      Divider(),
                    ],
                  )),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
