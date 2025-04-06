import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:jewellery_management/Theme/Colors.dart';
import 'package:jewellery_management/Theme/Fonts.dart';
import 'package:jewellery_management/View/Screens/billing/billing_page.dart';
import 'package:jewellery_management/View/Screens/billingHistory/BillingHistoryPage.dart';
import 'package:jewellery_management/View/Screens/product/add_edit_product.dart';
import 'package:jewellery_management/View/Screens/product/product_list.dart';
import 'package:jewellery_management/View/util/Popups.dart';
import '../../../Controller/BillingHistoryController.dart';
import '../../../Controller/LoginController.dart';
import '../../../Controller/product_controller.dart';
import '../../../Theme/appTheme.dart';
import '../../util/pdf_generator.dart';
import '../../widgets/customWidget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final BillingHistoryController controller =
      Get.put(BillingHistoryController());
  final ProductController productcontroller = Get.put(ProductController());
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: iconAppBarBackgroundless(
          title: Text("Dashboard", style: AppTextStyles.heading),
          implyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: "Logout",
              onPressed: () {
                showLogoutConfirmationDialog(context, () {
                  loginController.logout();
                });
              },
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome back, Sabarinathan",
                      style: AppTextStyles.subHeading),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatisticsCard("Products", Icons.inventory,
                          productcontroller.products.length.toString()),
                      StatisticsCard("Bills", Icons.receipt_long,
                          controller.allRecords.length.toString()),
                      StatisticsCard(
                        "Today\'s Revenue",
                        FontAwesomeIcons.arrowTrendUp,
                        "₹ ${controller.getTodayRevenue()}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text("Quick Actions",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Services("Add Product", Iconsax.add_circle,
                          () => Get.to(() => const AddEditProductPage())),
                      Services("New Bill", Iconsax.receipt,
                          () => Get.to(() => BillingPage())),
                    ],
                  ),
                  SizedBox(height: 10.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Services("History", Iconsax.timer,
                          () => Get.to(() => const BillingHistoryPage())),
                      Services("Product List", Iconsax.box,
                          () => Get.to(() => ProductListPage())),
                    ],
                  ),
                  SizedBox(height: 24.r),
                  Text("Recent Bills",
                      style: TextStyle(
                          fontSize: 18.r, fontWeight: FontWeight.w600)),
                  SizedBox(height: 10.r),
                  Obx(() {
                    final recent = controller.getRecentRecordsbills;

                    return recent.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                                child: Column(
                              children: [
                                const Icon(Iconsax.receipt),
                                SizedBox(height: 10.r),
                                const Text("No Recent bills Found"),
                              ],
                            )),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: recent.length,
                            itemBuilder: (context, index) {
                              final record = recent[index];
                              return Card(
                                color: whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 2,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    child: Text("#${index + 1}"),
                                  ),
                                  title: Text(
                                    "#INV-${index + 100} - ₹ ${record.total.toStringAsFixed(2)}",
                                    style:
                                        AppTextStyles.subHeading.withSize(18.r),
                                  ),
                                  subtitle: Text(
                                    DateFormat('dd-MM-yyyy hh:mm a')
                                        .format(record.timestamp.toLocal()),
                                    style: AppTextStyles.small.withSize(15.r),
                                  ),
                                  trailing: SizedBox(
                                    width: 80.r,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                insetPadding:
                                                    const EdgeInsets.all(40),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 20,
                                                      horizontal: 20),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Icon(Icons
                                                                  .receipt_long),
                                                              Text(
                                                                  "  Invoice Details",
                                                                  style: AppTextStyles
                                                                      .subHeading
                                                                      .withColor(
                                                                          blackColor)),
                                                            ],
                                                          ),
                                                          IconButton(
                                                              onPressed:
                                                                  Get.back,
                                                              icon: const Icon(
                                                                Icons.close,
                                                                color:
                                                                    greyColor,
                                                              ))
                                                        ],
                                                      ),
                                                      SizedBox(height: 20.r),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              height: 8),
                                                          Text(
                                                            "Date: ${DateFormat('dd-MM-yyyy').format(record.timestamp)}",
                                                            style: AppTextStyles
                                                                .body,
                                                          ),
                                                          Text(
                                                            "Time: ${DateFormat('hh:mm a').format(record.timestamp)}",
                                                            style: AppTextStyles
                                                                .body,
                                                          ),
                                                          const Divider(
                                                              height: 20,
                                                              thickness: 1),
                                                          ...record.items
                                                              .map((item) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          4),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                      child: Text(
                                                                          "${item.product.name} x${item.quantity}")),
                                                                  Text(
                                                                      "₹ ${item.itemTotal.toStringAsFixed(2)}"),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                          const Divider(
                                                              height: 20,
                                                              thickness: 1),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("Total",
                                                                  style:
                                                                      AppTextStyles
                                                                          .body
                                                                          .bold),
                                                              Text(
                                                                  "₹ ${record.total.toStringAsFixed(2)}",
                                                                  style:
                                                                      AppTextStyles
                                                                          .body
                                                                          .bold),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 16),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              SizedBox(
                                                                height: 50.r,
                                                                width:
                                                                    Get.width /
                                                                        3,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: const ButtonStyle(
                                                                      padding: WidgetStatePropertyAll(
                                                                          EdgeInsets
                                                                              .zero),
                                                                      backgroundColor:
                                                                          WidgetStatePropertyAll(
                                                                              greyColor20)),
                                                                  onPressed:
                                                                      () => Get
                                                                          .back(),
                                                                  child: Text(
                                                                    "Back",
                                                                    style:
                                                                        AppTextStyles
                                                                            .body,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 50.r,
                                                                width:
                                                                    Get.width /
                                                                        3,
                                                                child:
                                                                    ElevatedButton
                                                                        .icon(
                                                                  style: const ButtonStyle(
                                                                      padding: WidgetStatePropertyAll(
                                                                          EdgeInsets
                                                                              .zero)),
                                                                  onPressed: () =>
                                                                      InvoicePrinter
                                                                          .printInvoice(
                                                                              record),
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .print),
                                                                  label: const Text(
                                                                      "Print"),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: const Text("View"),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  }),
                ],
              ),
            )),
      ),
    );
  }
}
