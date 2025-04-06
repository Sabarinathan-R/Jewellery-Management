import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jewellery_management/Theme/Colors.dart';
import 'package:jewellery_management/Theme/appTheme.dart';
import 'package:jewellery_management/View/util/Formfield.dart';
import 'package:uuid/uuid.dart';

import '../../../Controller/product_controller.dart';
import '../../../Model/product_model.dart';
import '../../util/DummyList.dart';

class AddEditProductPage extends StatefulWidget {
  final Product? product;
  final int? index;

  const AddEditProductPage({super.key, this.product, this.index});

  @override
  State<AddEditProductPage> createState() => _AddEditProductPageState();
}

class _AddEditProductPageState extends State<AddEditProductPage> {
  final ProductController controller = Get.find();

  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final taxCtrl = TextEditingController();
  final discountCtrl = TextEditingController();
  String? categoryCtrl;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameCtrl.text = widget.product!.name;
      priceCtrl.text = widget.product!.price.toString();
      categoryCtrl = widget.product!.category.toString();
      taxCtrl.text = widget.product!.tax.toString();
      discountCtrl.text = widget.product!.discount.toString();
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    priceCtrl.dispose();
    taxCtrl.dispose();
    discountCtrl.dispose();
    super.dispose();
  }

  void saveProduct() {
    if (_formKey.currentState!.validate() && categoryCtrl != null) {
      final newProduct = Product(
        id: widget.product?.id ?? const Uuid().v4(),
        name: nameCtrl.text.trim(),
        price: double.tryParse(priceCtrl.text) ?? 0,
        category: categoryCtrl!,
        tax: double.tryParse(taxCtrl.text) ?? 0,
        discount: double.tryParse(discountCtrl.text) ?? 0,
      );

      if (widget.product == null) {
        controller.addProduct(newProduct);
      } else {
        controller.updateProduct(widget.index!, newProduct);
      }

      Get.back();
      Get.snackbar(
        "Product Updated Successfully",
        "Now You Can Start the Billing",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey,
        backgroundGradient: const LinearGradient(
          colors: [kPrimaryColor, Color.fromARGB(255, 248, 234, 109)],
        ),
      );
    } else {
      Get.snackbar("Empty Input Error", "Please Fill all the inputs ",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.grey,
          backgroundGradient: const LinearGradient(
            colors: [kPrimaryColor, Color.fromARGB(255, 248, 234, 109)],
          ),
          colorText: blackColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: iconAppBarBackgroundless(
          appBackgroundColor: kPrimaryColor,
          title: Text(widget.product == null ? 'Add Product' : 'Edit Product')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextInput(
                  LabelText: "Product Name",
                  Controller: nameCtrl,
                  HintText: "Enter Product Name",
                  ValidatorText: "Please enter product name",
                  onChanged: (_) {},
                ),
                SizedBox(height: 10.h),
                NumberInput(
                  isFloat: true,
                  LabelText: "Product Price",
                  Controller: priceCtrl,
                  HintText: "Enter Product Price",
                  ValidatorText: "Please enter product price",
                  onChanged: (_) {},
                ),
                SizedBox(height: 10.h),
                RadioOptionDropdown(
                  LabelText: "Product Category",
                  hintText: "Select Category",
                  validatorText: "Please select category",
                  items: categories,
                  initialValue: categoryCtrl,
                  onSelectionChanged: (value) {
                    setState(() {
                      categoryCtrl = value;
                    });
                  },
                ),
                SizedBox(height: 10.h),
                NumberInput(
                  LabelText: "Product Tax %",
                  Controller: taxCtrl,
                  isFloat: true,
                  HintText: "Enter Tax Percentage",
                  ValidatorText: "Please enter tax percentage",
                  onChanged: (_) {},
                ),
                SizedBox(height: 10.h),
                NumberInput(
                  LabelText: "Product Discount %",
                  Controller: discountCtrl,
                  isFloat: true,
                  HintText: "Enter Discount Percentage",
                  ValidatorText: "Please enter discount percentage",
                  onChanged: (_) {},
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: saveProduct,
                    child: Text(widget.product == null ? "Add" : "Update"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
