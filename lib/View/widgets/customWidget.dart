// views/widgets/reusable_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget customButton(String label, VoidCallback onPressed) => ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );

Widget customTextField(String hint, TextEditingController controller,
        {TextInputType type = TextInputType.text}) =>
    TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(labelText: hint),
    );
Widget StatisticsCard(String title, IconData icon, String value) {
  return Expanded(
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 140.r,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFFFFC107)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30.r, color: Colors.white),
            SizedBox(height: 8.r),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.r, color: Colors.white)),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.r,
                    color: Colors.white)),
          ],
        ),
      ),
    ),
  );
}

Widget Services(String label, IconData icon, VoidCallback onTap) {
  return SizedBox(
    width: Get.width / 2.3,
    height: 50,
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 20.r),
      label: Text(label, style: TextStyle(fontSize: 15.r)),
    ),
  );
}

Widget billingAmountRow(String label, double amount,
    {bool isTotal = false, bool isDiscount = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: isTotal ? 18.r : 14.r,
                fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
                color: isDiscount ? Colors.green : Colors.black87)),
        Text(
          "₹ ${amount.toStringAsFixed(2)}",
          style: TextStyle(
              fontSize: isTotal ? 18.r : 14.r,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isDiscount ? Colors.green : Colors.black87),
        ),
      ],
    ),
  );
}

Widget productRow(
  String label,
  String sublabel,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 14.r,
                fontWeight: FontWeight.w500,
                color: Colors.black87)),
        Text(
          sublabel,
          style: TextStyle(
              fontSize: 16.r,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
      ],
    ),
  );
}
