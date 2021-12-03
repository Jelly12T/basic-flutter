import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/order.dart';
import '../widgets/oder_item.dart';
import '../widgets/app_drawer.dart';

class OdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OdersScreen> createState() => _OdersScreenState();
}

class _OdersScreenState extends State<OdersScreen> {
  @override
  Widget build(BuildContext context) {
    print("xây lại cái order!!!");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Oder",
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataFuture) {
          if (dataFuture.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataFuture.error != null) {
              return Center(
                child: Text("Lỗi dữ liệu",
                    style: Theme.of(context).textTheme.bodyText2),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemBuilder: (ctx, index) {
                    return OrderCard(orderData.orders[index]);
                  },
                  itemCount: orderData.orders.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
