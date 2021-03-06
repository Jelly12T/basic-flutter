import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/auth.dart';
import 'package:store_app/providers/cart.dart';
import 'package:store_app/providers/product.dart';
import 'package:store_app/providers/products.dart';
import 'package:store_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDeatailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl!,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              product.isFavorite == true
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Theme.of(context).buttonColor,
            ),
            onPressed: () {
              product.toggleFavoriteStatus(authData.token!, authData.userId);

              print(product.isFavorite);
            },
          ),
          title: Text(
            product.title.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).buttonColor,
            ),
            onPressed: () {
              cart.addItem(product.id!, product.price!, product.title!);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "???? th??m v??o gi??? h??ng! ",
                  ),
                  duration: Duration(
                    seconds: 1,
                  ),
                  action: SnackBarAction(
                    label: "X??a",
                    onPressed: () {
                      cart.removeSingleItem(product.id!);
                    },
                    textColor: Colors.red,
                  ),
                ),
              );
            },
          ),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}
