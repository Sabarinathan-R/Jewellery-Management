import 'product_model.dart';

class BillItem {
  final Product product;
  int quantity;

  BillItem({required this.product, required this.quantity});

  double get itemTotal {
    final base = product.price * quantity;
    final discount = base * (product.discount / 100);
    final tax = (base - discount) * (product.tax / 100);
    return base - discount + tax;
  }

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
      };

  factory BillItem.fromJson(Map<String, dynamic> json) => BillItem(
        product: Product.fromJson(json['product']),
        quantity: json['quantity'],
      );
}
