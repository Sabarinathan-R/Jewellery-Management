import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jewellery_management/Theme/appTheme.dart';
import 'package:jewellery_management/View/widgets/customWidget.dart';
import '../../../Controller/product_controller.dart';
import '../../../Theme/Colors.dart';
import '../../../Theme/Fonts.dart';
import 'add_edit_product.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: iconAppBarBackgroundless(
          appBackgroundColor: kPrimaryColor,
          title: const Text("Jewellery Products")),
      body: Obx(() => controller.products.isEmpty
          ? const Center(child: Text("No products added yet."))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                // Reverse the index to show latest first
                final reversedIndex = controller.products.length - 1 - index;
                final product = controller.products[reversedIndex];

                return GestureDetector(
                  onTap: () =>
                      productDetailsPopup(context, product, reversedIndex),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 6,
                          spreadRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product.name.capitalizeFirst}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${product.category.capitalizeFirst}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                  "Price: ₹ ${product.price.toStringAsFixed(2)}"),
                              Text(
                                  "Tax: ${product.tax}%, Discount: ${product.discount}%"),
                            ],
                          ),
                        ),
                        const Icon(Icons.info_outline, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              },
            )),
    );
  }

  productDetailsPopup(BuildContext context, product, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.box),
                          Text("  Product Details",
                              style: AppTextStyles.subHeading
                                  .withColor(blackColor)),
                        ],
                      ),
                      IconButton(
                          onPressed: Get.back,
                          icon: const Icon(
                            Icons.close,
                            color: greyColor,
                          ))
                    ],
                  ),
                  SizedBox(height: 20.r),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      productRow('Name :', "${product.name}"),
                      SizedBox(height: 5.r),
                      productRow('Category :', "${product.category}"),
                      SizedBox(height: 5.r),
                      productRow(
                          'Price :', " ₹ ${product.price.toStringAsFixed(2)}"),
                      SizedBox(height: 5.r),
                      productRow('Tax :', "${product.tax}%"),
                      SizedBox(height: 5.r),
                      productRow('Discount :', "${product.discount}%"),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50.r,
                            width: Get.width / 3,
                            child: ElevatedButton.icon(
                              style: const ButtonStyle(
                                  padding:
                                      WidgetStatePropertyAll(EdgeInsets.zero)),
                              icon: const Icon(Icons.edit),
                              label: const Text("Edit"),
                              onPressed: () {
                                Get.back();
                                Get.to(() => AddEditProductPage(
                                    product: product, index: index));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50.r,
                            width: Get.width / 3,
                            child: ElevatedButton.icon(
                              style: const ButtonStyle(
                                  padding:
                                      WidgetStatePropertyAll(EdgeInsets.zero),
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.red)),
                              icon: const Icon(Icons.delete),
                              label: const Text("Delete"),
                              onPressed: () {
                                Get.back();

                                controller.deleteProduct(index);
                                Get.snackbar(
                                  "Product Deleted",
                                  "Add new products to Create a Bills",
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.grey,
                                  backgroundGradient: const LinearGradient(
                                    colors: [
                                      kPrimaryColor,
                                      Color.fromARGB(255, 248, 234, 109)
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        });
  }
}
