import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/widgets/app_drawer.dart';
import 'package:flutter_ecommerce/widgets/order_item.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
 var _isLoading=false;
  @override
  void initState() {
    /// we can use provider.of without future
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading=true;
      });
     await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    setState(() {
      _isLoading=true;
    });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body:_isLoading?Center(child: CircularProgressIndicator(),): ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => OrderItem(orderData.orders[index]),
      ),
    );
  }
}
