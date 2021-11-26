import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/product.dart';
import 'package:store_app/providers/products.dart';

class ProductDeatailScreen extends StatelessWidget {
  //final String? title;
  /// ProductDeatailScreen(this.title);
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productID);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedProduct.title.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl.toString(),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              child: Card(
                elevation: 5,
                color: Theme.of(context).backgroundColor,
                child: Text(
                  '\$${loadedProduct.price}',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              width: double.infinity,
              child: Text(
                loadedProduct.description.toString(),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
