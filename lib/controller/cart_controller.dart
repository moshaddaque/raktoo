import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;

  RxList cart = <QueryDocumentSnapshot>[].obs;
  RxDouble totalPrice = RxDouble(0.0);

  RxBool isLoading = RxBool(true);

  @override
  onInit() {
    super.onInit();
    getCart();
  }

  getCart() async {
    final firebaseCart = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .collection('cart')
        .get();

    isLoading.value = false;
    cart.value = firebaseCart.docs;

    // print(cart.length);

    calculateTotal();
    update();
  }

  increase(String doc) async {
    final product = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .collection('cart')
        .doc(doc)
        .get();

    // print(product);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .collection('cart')
        .doc(doc)
        .update({
      'quantity': product.data()!['quantity'] + 1,
    }).then((value) {
      getCart();
    });
  }

  descrease(String doc) async {
    final product = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .collection('cart')
        .doc(doc)
        .get();

    print(product);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .collection('cart')
        .doc(doc)
        .update({
      'quantity': product.data()!['quantity'] - 1,
    }).then((value) {
      getCart();
    });
  }

  calculateTotal() {
    double total = 0.0;
    for (var item in cart) {
      total += item['quantity'] * int.parse(item['price']);
    }
    totalPrice.value = total;
  }
}
