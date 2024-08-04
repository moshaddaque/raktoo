import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/products_model.dart';

class SearchesController extends GetxController {
  var query = ''.obs;
  var searchResults = <Product>[].obs;

  void searchProducts(String searchQuery) async {
    query.value = searchQuery;
    if (searchQuery.isEmpty) {
      searchResults.clear();
    } else {
      var results = await FirebaseFirestore.instance
          .collection('products')
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff')
          .get();
      searchResults.value = results.docs
          .map((doc) => Product.fromMap(doc.data(), doc.id))
          .toList();
    }
  }
}
