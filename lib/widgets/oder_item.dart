import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/order.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderCard extends StatefulWidget {
  final OrderItem order;
  OrderCard(this.order);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              '\$${widget.order.amount}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm')
                  .format(widget.order.dateTime as DateTime),
            ),
            trailing: IconButton(
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
              ),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
                print("expanded");
                print(_expanded);
              },
            ),
          ),
          if (_expanded == true)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: min(widget.order.products!.length * 20.0 + 100, 180),
              child: ListView(
                children: widget.order.products!
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              e.title.toString(),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Text(
                              '${e.quantity} x  ${e.price}',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
