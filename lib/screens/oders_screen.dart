import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/order.dart';
import '../widgets/oder_item.dart';
import '../widgets/app_drawer.dart';

class OdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final oderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Oder",
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          print("is empty");
          print(oderData.orders.isEmpty);
          return OrderCard(oderData.orders[index]);
        },
        itemCount: oderData.orders.length,
      ),
    );
  }
}
