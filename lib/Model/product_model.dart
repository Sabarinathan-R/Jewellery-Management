class Product {
  String id;
  String name;
  double price;
  String category;
  double tax;
  double discount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.tax,
    required this.discount,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        category: json['category'],
        tax: json['tax'],
        discount: json['discount'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'category': category,
        'tax': tax,
        'discount': discount,
      };
}
