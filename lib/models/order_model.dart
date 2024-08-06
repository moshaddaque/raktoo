import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  DateTime time;
  List<dynamic> items;
  double totalAmount;
  String deliveryStatus;
  DateTime? deliveryDate;

  OrderModel({
    required this.time,
    required this.totalAmount,
    required this.deliveryStatus,
    this.deliveryDate,
    required this.items,
  });

  factory OrderModel.fromMap(
    Map<String, dynamic> data,
  ) {
    return OrderModel(
      time: (data["time"] as Timestamp).toDate(),
      totalAmount: data['totalAmount'],
      deliveryStatus: data['status'],
      items: data['items'],
    );
  }
}
