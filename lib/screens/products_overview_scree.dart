import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_course_1/providers/cart_prodiver.dart';
import 'package:flutter_course_1/providers/products_provider.dart';
import 'package:flutter_course_1/screens/cart_screen.dart';
import 'package:flutter_course_1/widgets/app_drawer.dart';
import 'package:flutter_course_1/widgets/badge.dart';

import 'package:flutter_course_1/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions { ALL, FAVORITE }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;
  var _isLoading = false;
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() => _isLoading = true);
      await Provider.of<ProductsProvider>(context, listen: false)
          .loadProducts();
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          Consumer<Cart>(
            builder: (_, value, child) {
              return Badge(child: child, value: value.itemCount.toString());
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.FAVORITE) {
                _showOnlyFavorite = true;
              } else {
                _showOnlyFavorite = false;
              }
              setState(() {});
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.FAVORITE,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.ALL,
              )
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(showFavorite: _showOnlyFavorite),
        onRefresh: () async =>
            await Provider.of<ProductsProvider>(context, listen: false)
                .loadProducts(),
      ),
    );
  }
}
