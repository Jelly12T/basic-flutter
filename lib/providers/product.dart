import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

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

  void toggleFavoriteStatus() {
    if (isFavorite == true) {
      isFavorite = false;
    } else {
      isFavorite = true;
    }
    notifyListeners();
  }
}
