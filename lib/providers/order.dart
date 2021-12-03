import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/providers/cart.dart';

class OrderItem {
  final String? id;
  final double? amount;
  final List<CartItem>? products;
  final DateTime? dateTime;
  OrderItem({
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  Orders(this.authToken);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        "https://first-project-b20b6-default-rtdb.firebaseio.com/orders.json?auth=$authToken";
    final response = await http.get(Uri.parse(url));
    final List<OrderItem> loadedOrders = [];
    var extractedData = json.decode(response.body);
    if (extractedData == null) {
      return;
    }
    extractedData = extractedData as Map<String, dynamic>;
    extractedData.forEach(
      (key, value) {
        loadedOrders.add(
          OrderItem(
            id: key,
            amount: value['amount'],
            dateTime: DateTime.parse(
              value['dateTime'],
            ),
            products: (value['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                  ),
                )
                .toList(),
          ),
        );
      },
    );
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOder(List<CartItem> cartProducts, double total) async {
    final url =
        "https://first-project-b20b6-default-rtdb.firebaseio.com/orders.json?auth=$authToken";
    final timeNow = DateTime.now();
    final reponse = await http.post(
      Uri.parse(url),
      body: json.encode({
        'amount': total,
        'dateTime': timeNow.toIso8601String(),
        'products': cartProducts
            .map(
              (e) => {
                'id': e.id,
                'title': e.title,
                'quantity': e.quantity,
                'price': e.price,
              },
            )
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(reponse.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timeNow,
      ),
    );
    notifyListeners();
  }
}
