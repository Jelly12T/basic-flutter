import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final String? id;
  final String? productId;
  final double? price;
  final int? quantity;
  final String? title;
  CartItemWidget(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).backgroundColor,
        child: Icon(
          Icons.delete,
          color: Colors.red,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (val) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Bạn có chắc không ?'),
            content: Text(
              'Bạn có muốn xóa sản phẩm này không ?',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text(
                  'Không',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              FlatButton(
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text(
                  'Có',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(productId!);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text('\$${price}'),
                ),
              ),
            ),
            title: Text(
              title!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            subtitle: Text('Total: \$${price! * quantity!}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
