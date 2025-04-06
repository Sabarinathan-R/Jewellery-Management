import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jewellery_management/Model/BillingRecord.dart';
import 'package:jewellery_management/Theme/Colors.dart';
import 'package:jewellery_management/Theme/Fonts.dart';
import 'package:jewellery_management/Theme/appTheme.dart';
import '../../../Controller/BillingHistoryController.dart';
import '../../../Controller/billing_controller.dart';
import '../../../Controller/product_controller.dart';
import '../../util/SearchField.dart';
import '../../util/pdf_generator.dart';
import '../../widgets/customWidget.dart';

class BillingPage extends StatelessWidget {
  final productController = Get.put(ProductController());
  final billingController = Get.put(BillingController());
  final historyController = Get.put(BillingHistoryController());
  final searchQuery = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: iconAppBarBackgroundless(
          appBackgroundColor: kPrimaryColor, title: const Text("Billing")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Searchfield(
              onChanged: (val) => searchQuery.value = val,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                final filtered = productController.products.where((product) {
                  return product.name
                      .toLowerCase()
                      .contains(searchQuery.value.toLowerCase());
                }).toList();

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final product = filtered[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      child: ListTile(
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "${product.name.capitalizeFirst!} (${product.category})",
                          style: AppTextStyles.body.bold,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("₹ ${product.price.toInt()}"),
                            Text(
                                "Tax: ${product.tax} % || Discount: ${product.discount} %"),
                          ],
                        ),
                        trailing: SizedBox(
                          width: 80.r,
                          child: ElevatedButton.icon(
                            style: const ButtonStyle(
                                padding:
                                    WidgetStatePropertyAll(EdgeInsets.zero)),
                            icon: const Icon(Icons.add, size: 18),
                            label: Text(
                              "Add",
                              style: AppTextStyles.small.withColor(whiteColor),
                            ),
                            onPressed: () =>
                                billingController.addToBill(product),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const Divider(thickness: 1.2),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Billing Summary",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Icon(Icons.receipt_long_rounded),
              ],
            ),
            const SizedBox(height: 8),
            Obx(() => Column(
                  children: billingController.billItems.map((item) {
                    return billingAmountRow(
                        "${item.product.name} x${item.quantity}",
                        item.itemTotal);
                  }).toList(),
                )),
            const SizedBox(height: 8),
            Obx(() {
              double subtotal = 0.0;
              double totalTax = 0.0;
              double totalDiscount = 0.0;

              for (var item in billingController.billItems) {
                final price = item.product.price;
                final qty = item.quantity;
                final itemTotal = price * qty;

                final tax = itemTotal * (item.product.tax / 100);
                final discount = itemTotal * (item.product.discount / 100);

                subtotal += itemTotal;
                totalTax += tax;
                totalDiscount += discount;
              }

              final totalPayable = subtotal + totalTax - totalDiscount;

              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    billingAmountRow("Subtotal", subtotal),
                    billingAmountRow("Total Tax", totalTax),
                    billingAmountRow("Total Discount", -totalDiscount,
                        isDiscount: true),
                    const Divider(thickness: 1),
                    billingAmountRow("Total Payable", totalPayable,
                        isTotal: true),
                  ],
                ),
              );
            }),
            SizedBox(height: 10.r),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: billingController.isGenerating.value
                    ? const CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2)
                    : const Icon(Icons.picture_as_pdf_rounded),
                label: Text(
                  billingController.isGenerating.value
                      ? "Generating..."
                      : "Generate PDF Invoice",
                ),
                onPressed: billingController.isGenerating.value
                    ? null
                    : () async {
                        if (billingController.isGenerating.value) return;

                        if (billingController.billItems.isEmpty) {
                          Get.snackbar(
                            "Empty Bill",
                            "Please add at least one item before generating invoice.",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.grey,
                            backgroundGradient: const LinearGradient(
                              colors: [
                                kPrimaryColor,
                                Color.fromARGB(255, 248, 234, 109)
                              ],
                            ),
                            colorText: blackColor,
                          );
                          return;
                        }

                        billingController.isGenerating.value = true;

                        final record = BillingRecord(
                          items: billingController.billItems.toList(),
                          total: billingController.total,
                          timestamp: DateTime.now(),
                        );

                        await historyController.addRecord(record);

                        await PdfGenerator.generateInvoice(
                            billingController.billItems,
                            billingController.total);

                        billingController.clearBill();

                        Get.snackbar(
                          "Success",
                          "Invoice generated and saved successfully!",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.grey,
                          backgroundGradient: const LinearGradient(
                            colors: [
                              kPrimaryColor,
                              Color.fromARGB(255, 248, 234, 109)
                            ],
                          ),
                          colorText: blackColor,
                        );

                        billingController.isGenerating.value = false;
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
