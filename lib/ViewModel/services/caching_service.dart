import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../Model/product.dart';

class CacheService {
  static const _cacheKey = 'cachedProducts';
  static const _expiryKey = 'cacheExpiry';
  static const cacheDuration = Duration(hours: 1);

  Future<void> cacheProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final expiry = DateTime.now().add(cacheDuration).toIso8601String();
    prefs.setString(_expiryKey, expiry);
    prefs.setString(_cacheKey, jsonEncode(products.map((p) => p.toJson()).toList()));
  }

  Future<List<Product>?> getCachedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final expiry = prefs.getString(_expiryKey);
    if (expiry != null && DateTime.now().isBefore(DateTime.parse(expiry))) {
      final cachedData = prefs.getString(_cacheKey);
      if (cachedData != null) {
        final List<dynamic> jsonData = jsonDecode(cachedData);
        return jsonData.map((data) => Product.fromJson(data)).toList();
      }
    }
    return null;
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_expiryKey);
    prefs.remove(_cacheKey);
  }
}
