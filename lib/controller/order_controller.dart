import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/order_model.dart';

class OrderController extends GetxController {
  RxList orderList = <QueryDocumentSnapshot>[].obs;
  RxString selectedSize = RxString('');
  RxBool isLoading = RxBool(true);

  var orders = <OrderModel>[].obs;

  final user = FirebaseAuth.instance.currentUser;

  @override
  onInit() {
    super.onInit();
    getOrders();
    // getOrderList();
  }

  getOrders() async {
    try {
      // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      //     .collection('orders')
      //     .where('email', isEqualTo: user!.email)
      //     .orderBy('time', descending: true)
      //     .get();
      final data = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.email)
          .collection('order')
          .get();

      orders.value = data.docs
          .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  getOrderList() async {
    final data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .collection('order')
        .get();

    isLoading.value = false;
    orderList.value = data.docs;
    update();
  }

// addToOrder(List<Map<String, dynamic>> cartData) {
//   FirebaseFirestore.instance
//       .collection('Users')
//       .doc(user!.email)
//       .collection('order')
//       .add({
//     'user_email': user!.email,
//     'time': DateTime.now(),
//     'items': cartData,
//     'totalAmount': totalAmount,
//     // 'totalAmount' :
//   });
// }
}
