import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart ' as http;
import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavourite() async {
    final url = Uri.https(
      'shop-app-80e41-default-rtdb.firebaseio.com',
      '/products/$id.json',
    );

    final oldIsFavourite = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
/*     try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavourite': isFavourite,
          }));
      if (response.statusCode >= 400) {
        isFavourite = oldIsFavourite;
        notifyListeners();
        throw HttpException('Something went wrong when favouriting!');
      }
    } catch (error) {
      isFavourite = oldIsFavourite;
      notifyListeners();
      print(error);
      throw error;
    } */

    final response = await http.patch(url,
        body: json.encode({
          'isFavourite': isFavourite,
        }));
    if (response.statusCode >= 400) {
      isFavourite = oldIsFavourite;
      notifyListeners();
      throw HttpException('Something went wrong when favouriting!');
    }
  }

  Product copyWith({
    String id,
    String title,
    String description,
    double price,
    String imageUrl,
    bool isFavourite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
