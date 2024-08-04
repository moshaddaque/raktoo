import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  RxList orderList = <QueryDocumentSnapshot>[].obs;
  RxString selectedSize = RxString('');
  RxBool isLoading = RxBool(true);

  final user = FirebaseAuth.instance.currentUser;

  @override
  onInit() {
    super.onInit();
    getOrderList();
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

  addToOrder(List<Map<String, dynamic>> cartData) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .collection('order')
        .add({
      'user_email': user!.email,
      'time': DateTime.now(),
      'items': cartData,
    });
  }
}
