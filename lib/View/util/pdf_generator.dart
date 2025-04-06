// utils/pdf_generator.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import '../../Model/BillingRecord.dart';
import '../../Model/bill_model.dart';

class PdfGenerator {
  static Future<void> generateInvoice(
      List<BillItem> items, double total) async {
    final inter = pw.Font.ttf(
      await rootBundle.load('assets/fonts/inter.ttf'),
    );

    pw.TextStyle style({
      double size = 12,
      pw.FontWeight? weight,
    }) =>
        pw.TextStyle(
          fontSize: size,
          fontWeight: weight,
          fontFallback: [inter],
        );

    double totalTax = 0;
    double totalDiscount = 0;

    for (var item in items) {
      final price = item.product.price;
      final tax = price * item.product.tax / 100 * item.quantity;
      final discount = price * item.product.discount / 100 * item.quantity;

      totalTax += tax;
      totalDiscount += discount;
    }

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  "Golden Jewellers",
                  style: style(size: 22, weight: pw.FontWeight.bold),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  "Billing Invoice",
                  style: style(size: 16),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text("Items",
                  style: style(size: 14, weight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              ...items.map((item) {
                final basePrice = item.product.price;
                final tax = basePrice * item.product.tax / 100;
                final discount = basePrice * item.product.discount / 100;
                final finalPrice = (basePrice + tax - discount) * item.quantity;

                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("${item.product.name} x${item.quantity}",
                            style: style(weight: pw.FontWeight.bold)),
                        pw.Text("₹ ${finalPrice.toStringAsFixed(2)}",
                            style: style(weight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.Text("Base Price: ₹ ${basePrice.toStringAsFixed(2)}",
                        style: style(size: 10)),
                    pw.Text(
                        "Tax: ${item.product.tax}%  (₹ ${(tax * item.quantity).toStringAsFixed(2)})",
                        style: style(size: 10)),
                    pw.Text(
                        "Discount: ${item.product.discount}%  (₹ ${(discount * item.quantity).toStringAsFixed(2)})",
                        style: style(size: 10)),
                    pw.SizedBox(height: 8),
                  ],
                );
              }),
              pw.Divider(),
              pw.SizedBox(height: 6),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Total Tax",
                      style: style(weight: pw.FontWeight.bold)),
                  pw.Text("₹ ${totalTax.toStringAsFixed(2)}", style: style()),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Total Discount",
                      style: style(weight: pw.FontWeight.bold)),
                  pw.Text("₹ ${totalDiscount.toStringAsFixed(2)}",
                      style: style()),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Grand Total",
                      style: style(size: 16, weight: pw.FontWeight.bold)),
                  pw.Text("₹ ${total.toStringAsFixed(2)}",
                      style: style(size: 16, weight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Text("Cashier Signature: __________________________",
                  style: style()),
              pw.SizedBox(height: 8),
              pw.Text("Thank you for shopping with us!",
                  style: style(size: 12, weight: pw.FontWeight.normal)),
            ],
          ),
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/invoice.pdf");
    await file.writeAsBytes(await pdf.save());

    await Printing.layoutPdf(onLayout: (_) => pdf.save());
  }

  static Future<void> generateBillingHistory(
      List<BillingRecord> records) async {
    final inter = pw.Font.ttf(
      await rootBundle.load('assets/fonts/inter.ttf'),
    );

    pw.TextStyle style({double size = 12, pw.FontWeight? weight}) =>
        pw.TextStyle(
          fontSize: size,
          fontWeight: weight,
          fontFallback: [inter],
        );

    final pdf = pw.Document();

    for (var record in records) {
      double totalTax = 0;
      double totalDiscount = 0;

      for (var item in record.items) {
        totalTax += item.product.price * item.product.tax / 100 * item.quantity;
        totalDiscount +=
            item.product.price * item.product.discount / 100 * item.quantity;
      }

      pdf.addPage(
        pw.Page(
          build: (context) => pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                    "Date: ${DateFormat('dd-MM-yyyy').format(record.timestamp)}",
                    style: style(weight: pw.FontWeight.bold)),
                pw.Text(
                    "Time: ${DateFormat('hh:mm a').format(record.timestamp)}",
                    style: style()),
                pw.SizedBox(height: 10),
                ...record.items.map((item) {
                  final base = item.product.price;
                  final tax = base * item.product.tax / 100;
                  final discount = base * item.product.discount / 100;
                  final finalPrice = (base + tax - discount) * item.quantity;

                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("${item.product.name} x${item.quantity}",
                              style: style(weight: pw.FontWeight.bold)),
                          pw.Text("₹ ${finalPrice.toStringAsFixed(2)}",
                              style: style()),
                        ],
                      ),
                      pw.Text(
                          "Base: ₹ ${base.toStringAsFixed(2)} | Tax: ₹ ${(tax * item.quantity).toStringAsFixed(2)} | Discount: ₹ ${(discount * item.quantity).toStringAsFixed(2)}",
                          style: style(size: 10)),
                      pw.SizedBox(height: 6),
                    ],
                  );
                }),
                pw.Divider(),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Total Tax",
                        style: style(weight: pw.FontWeight.bold)),
                    pw.Text("₹ ${totalTax.toStringAsFixed(2)}", style: style()),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Total Discount",
                        style: style(weight: pw.FontWeight.bold)),
                    pw.Text("₹ ${totalDiscount.toStringAsFixed(2)}",
                        style: style()),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Grand Total",
                        style: style(size: 14, weight: pw.FontWeight.bold)),
                    pw.Text("₹ ${record.total.toStringAsFixed(2)}",
                        style: style(size: 14, weight: pw.FontWeight.bold)),
                  ],
                ),
                pw.SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    }

    await Printing.layoutPdf(onLayout: (_) => pdf.save());
  }
}

class InvoicePrinter {
  static Future<void> printInvoice(BillingRecord record) async {
    final inter = pw.Font.ttf(
      await rootBundle.load('assets/fonts/inter.ttf'),
    );

    pw.TextStyle customTextStyle({
      double fontSize = 12,
      pw.FontWeight? fontWeight,
      pw.FontStyle? fontStyle,
    }) {
      return pw.TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontFallback: [inter],
      );
    }

    final pdf = pw.Document();

    double totalTax = 0;
    double totalDiscount = 0;

    record.items.forEach((item) {
      totalTax += item.product.tax * item.quantity * item.product.price / 100;
      totalDiscount +=
          item.product.discount * item.quantity * item.product.price / 100;
    });

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    "Golden Jewellers",
                    style: customTextStyle(
                        fontSize: 22, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Center(
                  child: pw.Text(
                    "Official Billing Invoice",
                    style: customTextStyle(fontSize: 16),
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                    "Date: ${DateFormat('dd-MM-yyyy').format(record.timestamp)}",
                    style: customTextStyle()),
                pw.Text(
                    "Time: ${DateFormat('hh:mm a').format(record.timestamp)}",
                    style: customTextStyle()),
                pw.Divider(),
                pw.SizedBox(height: 8),
                pw.Text("Items",
                    style: customTextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 6),
                ...record.items.map((item) {
                  double price = item.product.price;
                  double tax = price * item.product.tax / 100;
                  double discount = price * item.product.discount / 100;
                  double finalPrice = (price + tax - discount) * item.quantity;

                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              "${item.product.name} x${item.quantity}",
                              style: customTextStyle(
                                  fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.Text("₹ ${finalPrice.toStringAsFixed(2)}",
                              style: customTextStyle(
                                  fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                      pw.Text("Base Price: ₹ ${price.toStringAsFixed(2)}",
                          style: customTextStyle(fontSize: 10)),
                      pw.Text(
                          "Tax: ${item.product.tax}%  (₹ ${tax.toStringAsFixed(2)})",
                          style: customTextStyle(fontSize: 10)),
                      pw.Text(
                          "Discount: ${item.product.discount}%  (₹ ${discount.toStringAsFixed(2)})",
                          style: customTextStyle(fontSize: 10)),
                      pw.SizedBox(height: 8),
                    ],
                  );
                }),
                pw.Divider(),
                pw.SizedBox(height: 6),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Total Tax",
                        style: customTextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("₹ ${totalTax.toStringAsFixed(2)}",
                        style: customTextStyle()),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Total Discount",
                        style: customTextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("₹ ${totalDiscount.toStringAsFixed(2)}",
                        style: customTextStyle()),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Grand Total",
                        style: customTextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.Text("₹ ${record.total.toStringAsFixed(2)}",
                        style: customTextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.SizedBox(height: 30),
                pw.Text("Cashier Signature: ________________________",
                    style: customTextStyle(fontSize: 12)),
                pw.SizedBox(height: 8),
                pw.Text("Thank you for your purchase!",
                    style: customTextStyle(fontStyle: pw.FontStyle.italic)),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
