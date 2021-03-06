import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/cart.dart';
import 'package:store_app/providers/products.dart';
import 'package:store_app/widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import 'cart_screen.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverViewScreen extends StatefulWidget {
  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _showOnlyFavorites = false;
  bool _inInit = true;
  bool _isloaded = false;
  @override
  void didChangeDependencies() {
    if (_inInit) {
      setState(() {
        _isloaded = true;
      });
      Provider.of<Products>(context).fetchAndSetProduct().then((value) {
        setState(() {
          _isloaded = false;
        });
      });
    }
    _inInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future<void> refershMain(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProduct();
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final Widget cartButtom = IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(CartScreen.routeName);
      },
      icon: Icon(
        Icons.shopping_cart,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("My shop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions val) {
              setState(() {
                if (val == FilterOptions.Favorite) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            color: Theme.of(context).backgroundColor,
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  "Only Favorites",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text(
                  "Show All",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                value: FilterOptions.All,
              )
            ],
          ),
          Badge(
            child: cartButtom,
            value: cartData.itemCount.toString(),
            color: Colors.red,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isloaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => refershMain(context),
              child: ProductsGrid(_showOnlyFavorites),
            ),
    );
  }
}
