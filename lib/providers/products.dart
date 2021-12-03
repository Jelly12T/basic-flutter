import 'product.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_app/main.dart';
import 'package:http/http.dart' as http;
import '../models/http_exceptiot.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  final String authToken;
  final String userId;
  Products(this.authToken, this.userId);
  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => (element.id == id));
  }

  List<Product> get favoriteItems {
    return _items.where((element) => (element.isFavorite == true)).toList();
  }

  Future<void> fetchAndSetProduct() async {
    var url =
        'https://first-project-b20b6-default-rtdb.firebaseio.com/products.json?auth=$authToken&orderBy="creatorId"&equalTo="$userId"';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://first-project-b20b6-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResonse = await http.get(Uri.parse(url));
      final favoriteData = json.decode(favoriteResonse.body);

      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(Product(
          id: productId,
          title: productData['title'],
          price: productData['price'],
          description: productData['description'],
          isFavorite: favoriteData == null
              ? false
              : (favoriteData[productId] == null
                  ? false
                  : favoriteData[productId]['isFavorite'] ?? false),
          imageUrl: productData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        "https://first-project-b20b6-default-rtdb.firebaseio.com/products.json?auth=$authToken";
    try {
      final response = await http.post(
        (Uri.parse(url)),
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
            'creatorId': userId,
          },
        ),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      // print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      final url =
          "https://first-project-b20b6-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'isFavorite': newProduct.isFavorite,
          }));
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print("chua co san pham nay ..... ");
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        "https://first-project-b20b6-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";
    final index = _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[index];

    _items.removeAt(index);

    final reponse = await http.delete(Uri.parse(url));
    if (reponse.statusCode >= 400) {
      _items.insert(index, existingProduct);
      throw HttpException("Không thể xóa sản phầm này!");
    }

    notifyListeners();
  }
}
