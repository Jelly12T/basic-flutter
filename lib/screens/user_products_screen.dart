import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/screens/edit_product_screen.dart';
import 'package:store_app/widgets/app_drawer.dart';
import '../widgets/user_product.dart';
import '../providers/products.dart';
import '../screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your products",
          style: Theme.of(context).textTheme.subtitle2,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routName);
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (ctx, index) => UserProductItem(
              productData.items[index].id,
              productData.items[index].title,
              productData.items[index].imageUrl,
            ),
            itemCount: productData.items.length,
          ),
        ),
      ),
    );
  }
}
