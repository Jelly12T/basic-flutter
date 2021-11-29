import 'package:flutter/material.dart';
import 'package:store_app/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final String? id;

  UserProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(
          title.toString(),
          style: Theme.of(context).textTheme.bodyText2,
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl ?? ''),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routName,
                    arguments: id,
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .deleteProduct(id!);
                    scaffold.showSnackBar(
                      SnackBar(
                          content: Text(
                        "Đã xóa sản phẩm thành công",
                        style: TextStyle(
                          color: Colors.greenAccent,
                        ),
                        textAlign: TextAlign.center,
                      )),
                    );
                  } catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Xóa sản phẩm thất bại',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
