class Product {
  final String id;
  final String productName;
  final String catId;
  final String description;
  final String image;
  final String productPrice;
  final String? previousPrice;
  final String? sale;
  final bool isStockAvailable;

  Product({
    required this.id,
    required this.productName,
    required this.catId,
    required this.description,
    required this.image,
    required this.isStockAvailable,
    required this.productPrice,
    this.previousPrice,
    this.sale,
  });

  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      productName: data['name'] ?? '',
      description: data['description'] ?? '',
      productPrice: data['product_price'],
      previousPrice: data['previous_price'],
      sale: data['sale'],
      image: data['image_link'],
      catId: data['cat_id'] ?? '',
      isStockAvailable: data['stock'] ?? true,
    );
  }
}
