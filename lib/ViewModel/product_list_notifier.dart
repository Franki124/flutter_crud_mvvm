import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/product.dart';
import 'package:logger/logger.dart';

class ProductListNotifier extends StateNotifier<List<Product>> {
  ProductListNotifier() : super([]) {
    _loadProducts();
  }

  var logger = Logger();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _loadProducts() async {
    try {
      final snapshot = await _firestore.collection('products').get();
      final products = snapshot.docs
          .map((doc) => Product(
                id: doc.id,
                name: doc['name'],
                description: doc['description'],
                price: doc['price'],
                history: (doc['history'] as List<dynamic>?)
                    ?.map((e) => Map<String, String>.from(e))
                    .toList(),
              ))
          .toList();
      state = products;
    } catch (e) {
      logger.e('Error occurred', error: e, stackTrace: StackTrace.current);
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final docRef = await _firestore.collection('products').add({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'history': product.history?.map((e) => e).toList(),
      });
      product.id = docRef.id;
      state = [...state, product];
    } catch (e) {
      logger.e('Error occurred', error: e, stackTrace: StackTrace.current);
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _firestore.collection('products').doc(product.id).update({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'history': product.history?.map((e) => e).toList(),
      });
      state = state.map((p) => p.id == product.id ? product : p).toList();
    } catch (e) {
      logger.e('Error occurred', error: e, stackTrace: StackTrace.current);
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      state = state.where((product) => product.id != productId).toList();
    } catch (e) {
      logger.e('Error occurred', error: e, stackTrace: StackTrace.current);
    }
  }
}

final productListProvider =
StateNotifierProvider<ProductListNotifier, List<Product>>((ref) {
  return ProductListNotifier();
});
