import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/providers/cart.dart';
import 'package:flutter_ecommerce/providers/orders.dart';
import 'package:flutter_ecommerce/screens/cart_screen.dart';
import 'package:flutter_ecommerce/screens/orders_screen.dart';
import 'package:flutter_ecommerce/screens/product_detail_screen.dart';
import 'package:flutter_ecommerce/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

import 'providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}
