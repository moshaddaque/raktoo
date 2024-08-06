import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:raktoo/models/products_model.dart';

class ProductController extends GetxController {
  RxInt selectedIndex = RxInt(0);
  RxString selectedSize = RxString('');
  var products = <Product>[].obs;
  var cat = [].obs;
  RxBool isLoading = true.obs;

  RxList sizes = [].obs;
  final user = FirebaseAuth.instance.currentUser;

  addToCart(Product product) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .collection('cart')
        .add({
      'user_email': user!.email,
      "product_id": product.id,
      "product_name": product.productName,
      "price": product.productPrice,
      'product_image': product.image,
      'variant': selectedSize.value,
      'quantity': 1,
    }).then(
      (value) => Get.snackbar("Success", "Product successfully added to cart"),
    );
  }

  getProductsByCategory(String catId) async {
    // final getCat = await FirebaseFirestore.instance.collection("categories").get();
    //   // print(data.docs.length);
    //   // print(data.docs.first.data()['name']);
    // for (var element in getCat.docs) {
    //   cat.value = (element.data()['id']);
    // }

    try {
      final data = await FirebaseFirestore.instance
          .collection("products")
          .where('cat_id', isEqualTo: catId)
          .get();

      products.value = data.docs
          .map((doc) =>
              Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      print("error: $e");
    }
  }
}
