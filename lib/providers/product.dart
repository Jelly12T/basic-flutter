import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool? isFavorite;
  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String id) async {
    final url =
        "https://first-project-b20b6-default-rtdb.firebaseio.com/products/$id.json";
    final response = await http.get(Uri.parse(url));
    final myProduct = json.decode(response.body) as Map<String, dynamic>;
    if (myProduct['isFavorite'] == true) {
      await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'isFavorite': false,
          },
        ),
      );
      isFavorite = false;
    } else {
      await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'isFavorite': true,
          },
        ),
      );
      isFavorite = true;
    }

    notifyListeners();
  }
}
