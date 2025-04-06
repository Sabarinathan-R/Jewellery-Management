// controllers/product_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/product_model.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  final String _key = "products";

  @override
  void onInit() {
    loadProducts();
    super.onInit();
  }

  void addProduct(Product product) {
    products.add(product);
    saveProducts();
  }

  void updateProduct(int index, Product product) {
    products[index] = product;
    saveProducts();
  }

  void deleteProduct(int index) {
    products.removeAt(index);
    saveProducts();
  }

  void saveProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> productStrings =
        products.map((p) => jsonEncode(p.toJson())).toList();
    prefs.setStringList(_key, productStrings);
  }

  void loadProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? productStrings = prefs.getStringList(_key);
    if (productStrings != null) {
      products.value =
          productStrings.map((p) => Product.fromJson(jsonDecode(p))).toList();
    }
  }
}
