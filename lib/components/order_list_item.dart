import 'package:flutter/material.dart';
import 'package:raktoo/models/order_model.dart';

class OrderListItem extends StatelessWidget {
  final OrderModel order;

  const OrderListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text("Order Time: ${order.time}"),
            Text('Total Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
            Text('Delivery Status: ${order.deliveryStatus}'),
            if (order.deliveryDate != null)
              Text('Delivery Date: ${order.deliveryDate}'),
            const SizedBox(height: 8.0),
            const Text('Items:'),
            ...order.items.map((item) => Text(item['product_name'])).toList(),
          ],
        ),
      ),
    );
  }
}
