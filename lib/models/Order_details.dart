import 'Product.dart';

class OrderDetails {
  final Product product;
  final String order_status;

  OrderDetails({required this.product, required this.order_status});
}

// Demo data for our cart

List<OrderDetails> demoOrders = [
  OrderDetails(product: demoProducts[0], order_status: "rejected"),
  OrderDetails(product: demoProducts[1], order_status: "Repair Cost is 21000"),
  OrderDetails(product: demoProducts[3], order_status: "In Pending"),
];
