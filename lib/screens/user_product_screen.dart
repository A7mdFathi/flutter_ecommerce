import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/edit_product_screen.dart';
import 'package:flutter_ecommerce/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/app_drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context)async{
   await Provider.of<Products>(context,listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final prodcutsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('your prodcutData'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh:()=> _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: prodcutsData.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserProductItem(
                  prodcutsData.items[index].id,
                  prodcutsData.items[index].title,
                  prodcutsData.items[index].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
