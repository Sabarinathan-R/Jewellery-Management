import 'package:get/get.dart';
import '../Model/bill_model.dart';
import '../Model/product_model.dart';

class BillingController extends GetxController {
  RxList<BillItem> billItems = <BillItem>[].obs;
  var isGenerating = false.obs;

  void addToBill(Product product) {
    final index = billItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      billItems[index].quantity += 1;
      billItems[index] = billItems[index];
    } else {
      billItems.add(BillItem(product: product, quantity: 1));
    }
  }

  void removeFromBill(BillItem item) {
    billItems.remove(item);
  }

  double get total {
    return billItems.fold(0, (sum, item) => sum + item.itemTotal);
  }

  void clearBill() {
    billItems.clear();
  }
}
