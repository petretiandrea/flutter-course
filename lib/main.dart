import 'package:flutter/material.dart';
import 'package:flutter_course_1/helpers/custom_route.dart';
import 'package:flutter_course_1/providers/auth.dart';
import 'package:flutter_course_1/providers/cart_prodiver.dart';
import 'package:flutter_course_1/providers/orders_prodiver.dart';
import 'package:flutter_course_1/providers/products_provider.dart';
import 'package:flutter_course_1/screens/auth_screen.dart';
import 'package:flutter_course_1/screens/cart_screen.dart';
import 'package:flutter_course_1/screens/edit_product_screen.dart';
import 'package:flutter_course_1/screens/orders_screen.dart';
import 'package:flutter_course_1/screens/product_detail_screen.dart';
import 'package:flutter_course_1/screens/products_overview_scree.dart';
import 'package:flutter_course_1/screens/splash_screen.dart';
import 'package:flutter_course_1/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (context) => ProductsProvider("", "", []),
          update: (context, value, previous) =>
              ProductsProvider(value.token, value.userId, previous.products),
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders("", "", []),
          update: (context, value, previous) => Orders(
            value.token,
            value.userId,
            previous.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'My Shop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                // here can be setup a different transition for different platform
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder()
              }),
            ),
            home: auth.isAuth
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SplashScreen();
                      } else {
                        return AuthScreen();
                      }
                    },
                  ),
            routes: {
              ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
              CartScreen.routeName: (_) => CartScreen(),
              OrdersScreen.routeName: (_) => OrdersScreen(),
              UserProductsScreen.routeName: (_) => UserProductsScreen(),
              EditProductScreen.routeName: (_) => EditProductScreen(),
              AuthScreen.routeName: (_) => AuthScreen(),
            },
          );
        },
      ),
    );
  }
}
