import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/controller/order_controller.dart';
import 'package:raktoo/views/home/home.dart';

class PaymentView extends StatelessWidget {
  final List<Map<String, dynamic>> cartData;
  final double totalAmount;

  const PaymentView({
    super.key,
    required this.cartData,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final controller = Get.put(OrderController());
    createOrder() async {
      final userDetails = await await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.email)
          .get();
      await FirebaseFirestore.instance.collection('orders').add({
        'email': user.email,
        'userName': userDetails.data()!['full_name'],
        'address': userDetails.data()!['address'],
        'phoneNumber': userDetails.data()!['phone_number'],
        'time': DateTime.now(),
        'items': cartData,
        'gateway_name': 'bKash',
        'trx_id': 'AUU&HB#&ds55',
      }).then((value) async {
        final cart = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.email)
            .collection('cart')
            .get();

        for (var item in cart.docs) {
          await item.reference.delete();
        }
      }).then((value) {
        Get.snackbar('Complete', 'Your order has been placed');
      });
    }

    return Scaffold(
      appBar: MyAppBar(
        title: "Payment Now",
      ),
      body: ListTile(
        onTap: () {
          createOrder();
          controller.addToOrder(cartData);
          Get.offAll(() => const Home());
        },
        leading: Image.network(
            'https://seeklogo.com/images/B/bkash-logo-0C1572FBB4-seeklogo.com.png'),
        title: Text('bKash Payment'),
        subtitle: Text(
          'Pay with bkash',
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
