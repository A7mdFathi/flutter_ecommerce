import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/providers/auth.dart';
import 'package:flutter_ecommerce/providers/cart.dart';
import 'package:flutter_ecommerce/providers/orders.dart';
import 'package:flutter_ecommerce/screens/auth_screen.dart';
import 'package:flutter_ecommerce/screens/cart_screen.dart';
import 'package:flutter_ecommerce/screens/edit_product_screen.dart';
import 'package:flutter_ecommerce/screens/orders_screen.dart';
import 'package:flutter_ecommerce/screens/product_detail_screen.dart';
import 'package:flutter_ecommerce/screens/products_overview_screen.dart';
import 'package:flutter_ecommerce/screens/user_product_screen.dart';
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
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (context, auth, previousProducts) => Products(
            auth.token,
           auth.userId ,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(

          update: (context, auth, previousOrders) => Orders(
            auth.token,
            previousOrders == null ? [] : previousOrders.authToken,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'Shop App',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'),
          home: authData.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductScreen.routeName: (context) => UserProductScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
