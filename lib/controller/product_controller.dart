import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:raktoo/models/products_model.dart';

class ProductController extends GetxController {
  RxInt selectedIndex = RxInt(0);
  RxString selectedSize = RxString('');

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
}
