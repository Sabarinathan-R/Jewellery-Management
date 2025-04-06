import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:jewellery_management/Theme/Colors.dart';
import 'package:jewellery_management/Theme/Fonts.dart';
import 'package:jewellery_management/Theme/appTheme.dart';
import '../../../Controller/BillingHistoryController.dart';
import '../../util/SearchField.dart';

import '../../util/pdf_generator.dart';

class BillingHistoryPage extends StatefulWidget {
  const BillingHistoryPage({super.key});

  @override
  State<BillingHistoryPage> createState() => _BillingHistoryPageState();
}

class _BillingHistoryPageState extends State<BillingHistoryPage> {
  final controller = Get.put(BillingHistoryController());

  bool isdatepicker = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: iconAppBarBackgroundless(
          appBackgroundColor: kPrimaryColor,
          title: const Text("Billing History")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Searchfield(
                    onChanged: controller.search,
                  ),
                ),
                isdatepicker
                    ? SizedBox(
                        width: 50.r,
                        child: IconButton(
                          icon: const Icon(Iconsax.refresh),
                          tooltip: "Reset Filter",
                          onPressed: () {
                            controller.resetFilter();
                            setState(() {
                              isdatepicker = false;
                            });
                          },
                        ),
                      )
                    : SizedBox(
                        width: 50.r,
                        child: IconButton(
                          icon: const Icon(Iconsax.calendar_edit),
                          tooltip: "Filter by Date",
                          onPressed: () async {
                            DateTimeRange? picked = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      secondary: kPrimaryColor.withOpacity(.5),
                                      primary:
                                          kPrimaryColor, // Customize primary color
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black87,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor:
                                            Colors.black, // Button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              controller.filterByDate(picked.start, picked.end);
                              setState(() {
                                isdatepicker = true;
                              });
                            }
                          },
                        ),
                      ),
                Obx(() => SizedBox(
                      width: 50.r,
                      child: IconButton(
                        icon: const Icon(Iconsax.arrange_circle),
                        tooltip: controller.isAscending.value
                            ? "Sort by Amount ↑"
                            : "Sort by Amount ↓",
                        onPressed: () {
                          controller.toggleSortByTotal();
                        },
                      ),
                    )),
              ],
            ),
          ),
          controller.displayedRecords.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: Text("No Records Found")),
                )
              : Expanded(
                  child: Obx(() => ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(height: 1);
                      },
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemCount: controller.displayedRecords.length,
                      itemBuilder: (context, index) {
                        if (index == controller.displayedRecords.length) {
                          if (controller.hasMore.value == false) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: Text("No more records")),
                            );
                          } else {
                            controller.loadMore();
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        }

                        final record = controller.displayedRecords[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                              title: Text(
                                "₹ ${record.total.toStringAsFixed(2)}",
                                style: AppTextStyles.body.bold,
                              ),
                              subtitle: Text(
                                "${record.items.map((e) => e.product.name.capitalizeFirst).join(", ")}\n${DateFormat('dd-MM-yyyy | hh:mm a').format(record.timestamp.toLocal())}",
                                style: AppTextStyles.body.withColor(textcolor),
                              ),
                              trailing: const Icon(Icons.receipt_long_rounded),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        insetPadding: const EdgeInsets.all(40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.receipt_long),
                                                      Text("  Invoice Details",
                                                          style: AppTextStyles
                                                              .subHeading
                                                              .withColor(
                                                                  blackColor)),
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    "Date: ${DateFormat('dd-MM-yyyy').format(record.timestamp)}",
                                                    style: AppTextStyles.body,
                                                  ),
                                                  Text(
                                                    "Time: ${DateFormat('hh:mm a').format(record.timestamp)}",
                                                    style: AppTextStyles.body,
                                                  ),
                                                  const Divider(
                                                      height: 20, thickness: 1),
                                                  ...record.items.map((item) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4),
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
                                                  }).toList(),
                                                  const Divider(
                                                      height: 20, thickness: 1),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Total",
                                                          style: AppTextStyles
                                                              .body.bold),
                                                      Text(
                                                          "₹ ${record.total.toStringAsFixed(2)}",
                                                          style: AppTextStyles
                                                              .body.bold),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        height: 50.r,
                                                        width: Get.width / 3,
                                                        child: ElevatedButton(
                                                          style: const ButtonStyle(
                                                              padding:
                                                                  WidgetStatePropertyAll(
                                                                      EdgeInsets
                                                                          .zero),
                                                              backgroundColor:
                                                                  WidgetStatePropertyAll(
                                                                      greyColor20)),
                                                          onPressed: () =>
                                                              Get.back(),
                                                          child: Text(
                                                            "Back",
                                                            style: AppTextStyles
                                                                .body,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 50.r,
                                                        width: Get.width / 3,
                                                        child:
                                                            ElevatedButton.icon(
                                                          style: const ButtonStyle(
                                                              padding:
                                                                  WidgetStatePropertyAll(
                                                                      EdgeInsets
                                                                          .zero)),
                                                          onPressed: () =>
                                                              InvoicePrinter
                                                                  .printInvoice(
                                                                      record),
                                                          icon: const Icon(
                                                              Icons.print),
                                                          label: const Text(
                                                              "Print"),
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
                              }),
                        );
                      })),
                ),
        ],
      ),
    );
  }
}
