import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/order.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart!"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    backgroundColor: Theme.of(context).backgroundColor,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Card(
                      elevation: 10,
                      child: FlatButton(
                        onPressed: () {
                          if (cart.itemCount == 0) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(
                                  "Chưa có sản phẩm nào!!",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                content: Text(
                                  "Vui lòng chọn thêm sản phẩm",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            );
                          } else {
                            Provider.of<Orders>(context, listen: false).addOder(
                              cart.items.values.toList(),
                              cart.totalAmount,
                            );
                            cart.clearn();
                          }
                        },
                        child: Text(
                          'ORDER NOW',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, index) => CartItemWidget(
                cart.items.values.toList()[index].id,
                cart.items.keys.toList()[index],
                cart.items.values.toList()[index].price,
                cart.items.values.toList()[index].quantity,
                cart.items.values.toList()[index].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
