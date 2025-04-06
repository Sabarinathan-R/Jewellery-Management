import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Theme/Colors.dart';
import '../../Theme/appTheme.dart';

class LRNumberInput extends StatelessWidget {
  final String LabelText, HintText, ValidatorText;
  final TextEditingController Controller;
  final IconData IconName;
  final bool isContactnumber;
  final bool readOnly;
  final bool validationRequired;
  final Function(String) onChanged;

  const LRNumberInput(
      {super.key,
      required this.LabelText,
      required this.Controller,
      required this.HintText,
      required this.ValidatorText,
      required this.IconName,
      this.readOnly = false,
      this.isContactnumber = false,
      this.validationRequired = true,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              LabelText,
              style: TextStyle(
                fontSize: Get.width / 28,
                letterSpacing: .5,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            const SizedBox(width: 5),
            validationRequired
                ? Text(
                    "*",
                    style: TextStyle(
                      fontSize: Get.width / 28,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: TextInputType.number,
          cursorColor: kPrimaryColor,
          controller: Controller,
          readOnly: readOnly,
          maxLength: isContactnumber ? 10 : null,
          buildCounter: (BuildContext context,
              {int? currentLength, int? maxLength, bool? isFocused}) {
            return null;
          },
          onChanged: onChanged,
          decoration: InputDecoration(
              prefixIcon: Icon(
                IconName,
                color: greyColor,
                size: Get.width / 24,
              ),
              filled: true,
              fillColor: greyColor10,
              hintText: HintText,
              hintStyle:
                  TextStyle(fontSize: Get.width / 32, color: greyColor80),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              enabledBorder: EnabledBorder(),
              focusedBorder: FocusedBorder(),
              errorBorder: ErrorBorder(),
              focusedErrorBorder: FocusedErrorBorder()),
          validator: (value) {
            if (!validationRequired) {
              return null;
            }
            if (value == null || value.isEmpty) {
              return ValidatorText;
            }
            if (isContactnumber == true) {
              if (value.length != 10) {
                return 'Please Enter a valid 10-digit contact number';
              }
            }

            RegExp regExp = RegExp(r'^[0-9]+$'); // Allows only numbers
            // Check if the input is empty or doesn't match the regex pattern
            if (!regExp.hasMatch(value)) {
              return 'Please Enter a valid input ';
            }

            return null;
          },
        ),
      ],
    );
  }
}

class NumberInput extends StatelessWidget {
  final String LabelText, HintText, ValidatorText;
  final TextEditingController Controller;
  final bool readOnly;
  final bool validationRequired;
  final bool isFloat;
  final bool isContactnumber;
  final int maxcount;
  final bool pcontact;
  final String CoLabelText;
  final Function(String) onChanged;

  const NumberInput({
    super.key,
    required this.LabelText,
    required this.Controller,
    required this.HintText,
    required this.ValidatorText,
    this.readOnly = false,
    this.validationRequired = true,
    this.isFloat = false,
    this.isContactnumber = false,
    this.maxcount = 0,
    this.pcontact = false,
    required this.onChanged,
    this.CoLabelText = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              LabelText,
              style: TextStyle(
                fontSize: Get.width / 28,
                letterSpacing: .5,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            const SizedBox(width: 5),
            validationRequired
                ? Text(
                    "*",
                    style: TextStyle(
                      fontSize: Get.width / 28,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        CoLabelText == ''
            ? const SizedBox.shrink()
            : Text(
                CoLabelText,
                style: TextStyle(
                  fontSize: Get.width / 32,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w500,
                  color: greyColor,
                ),
              ),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: readOnly,
          keyboardType: TextInputType.number,
          cursorColor: kPrimaryColor,
          controller: Controller,
          onChanged: onChanged,
          maxLength: maxcount > 0
              ? maxcount
              : isContactnumber
                  ? 10
                  : null,
          buildCounter: (BuildContext context,
              {int? currentLength, int? maxLength, bool? isFocused}) {
            return null; // This hides the maxLength counter
          },
          decoration: InputDecoration(
              hintStyle:
                  TextStyle(fontSize: Get.width / 32, color: greyColor80),
              filled: true,
              fillColor: whiteColor,
              hintText: pcontact ? "Enter your $HintText" : HintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              enabledBorder: EnabledBorder(),
              focusedBorder: FocusedBorder(),
              errorBorder: ErrorBorder(),
              focusedErrorBorder: FocusedErrorBorder()),
          validator: (value) {
            // Skip validation if _validationRequired is false
            if (!validationRequired) {
              return null;
            }
            if (value == null || value.isEmpty) {
              return ValidatorText;
            }

            RegExp regExp = isFloat
                ? RegExp(r'^-?[0-9]+(\.[0-9]+)?$')
                : RegExp(r'^[0-9]+$'); // Allows only numbers
            // Check if the input is empty or doesn't match the regex pattern
            if (!regExp.hasMatch(value)) {
              return 'Please Enter a valid input ';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class LRTextInput extends StatelessWidget {
  final String LabelText, HintText, ValidatorText;
  final TextEditingController Controller;
  final IconData IconName;
  final bool readOnly;
  final bool validationRequired;

  const LRTextInput({
    super.key,
    required this.LabelText,
    required this.Controller,
    required this.HintText,
    required this.ValidatorText,
    required this.IconName,
    this.readOnly = false,
    this.validationRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              LabelText,
              style: TextStyle(
                fontSize: Get.width / 28,
                letterSpacing: .5,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            const SizedBox(width: 5),
            validationRequired
                ? Text(
                    "*",
                    style: TextStyle(
                      fontSize: Get.width / 28,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: TextInputType.text,
          cursorColor: kPrimaryColor,
          controller: Controller,
          readOnly: readOnly,
          decoration: InputDecoration(
              prefixIcon: Icon(
                IconName,
                color: kPrimaryColor,
                size: Get.width / 24,
              ),
              filled: true,
              fillColor: whiteColor,
              hintText: "Enter the $HintText",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              enabledBorder: EnabledBorder(),
              focusedBorder: FocusedBorder(),
              errorBorder: ErrorBorder(),
              focusedErrorBorder: FocusedErrorBorder()),
          validator: (value) {
            if (!validationRequired) {
              return null;
            }
            if (value == null || value.isEmpty) {
              return ValidatorText;
            }

            return null;
          },
        ),
      ],
    );
  }
}

class TextInput extends StatelessWidget {
  final String LabelText, HintText, ValidatorText, CoLabelText;
  final TextEditingController Controller;
  final bool readOnly;
  final bool validationRequired;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final int maxcount;
  final bool nameinput;

  const TextInput(
      {super.key,
      required this.LabelText,
      required this.Controller,
      required this.HintText,
      required this.ValidatorText,
      this.readOnly = false,
      this.validationRequired = true,
      required this.onChanged,
      this.maxcount = 0,
      this.onTap,
      this.nameinput = false,
      this.CoLabelText = "",
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              LabelText,
              style: TextStyle(
                fontSize: Get.width / 28,
                letterSpacing: .5,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            const SizedBox(width: 5),
            validationRequired
                ? Text(
                    "*",
                    style: TextStyle(
                      fontSize: Get.width / 28,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        CoLabelText == ''
            ? const SizedBox.shrink()
            : Text(
                CoLabelText,
                style: TextStyle(
                  fontSize: Get.width / 32,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w500,
                  color: greyColor,
                ),
              ),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: readOnly,
          maxLength: maxcount > 0 ? maxcount : null,
          buildCounter: (BuildContext context,
              {int? currentLength, int? maxLength, bool? isFocused}) {
            return null; // This hides the maxLength counter
          },
          keyboardType: nameinput ? TextInputType.name : TextInputType.text,
          cursorColor: kPrimaryColor,
          controller: Controller,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          onTap: onTap,
          decoration: InputDecoration(
              hintStyle:
                  TextStyle(fontSize: Get.width / 32, color: greyColor80),
              filled: true,
              fillColor: whiteColor,
              hintText: nameinput ? "Enter your $HintText" : HintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              enabledBorder: EnabledBorder(),
              focusedBorder: FocusedBorder(),
              errorBorder: ErrorBorder(),
              focusedErrorBorder: FocusedErrorBorder()),
          validator: (value) {
            // Skip validation if _validationRequired is false
            if (!validationRequired) {
              return null;
            }
            if (value == null || value.isEmpty) {
              return ValidatorText;
            }
            return null;
          },
        ),
      ],
    );
  }
}

class DropdownInput extends StatefulWidget {
  final String LabelText, hintText, validatorText;
  final String? dropdownValue;
  final List<String> dropdownList;
  final bool validationRequired;
  final ValueChanged<String?> onChanged;

  const DropdownInput({
    Key? key,
    required this.LabelText,
    required this.hintText,
    required this.validatorText,
    this.dropdownValue, // Nullable to allow no selection initially
    required this.dropdownList, // Expecting a non-null list
    required this.onChanged,
    this.validationRequired = true,
  }) : super(key: key);

  @override
  _DropdownInputState createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.dropdownValue; // Initialize with widget's value
  }

  @override
  void didUpdateWidget(DropdownInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dropdownValue != dropdownValue) {
      setState(() {
        dropdownValue = widget.dropdownValue; // Update if the value changes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.LabelText,
              style: TextStyle(
                fontSize: Get.width / 28,
                letterSpacing: .5,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            const SizedBox(width: 5),
            widget.validationRequired
                ? Text(
                    "*",
                    style: TextStyle(
                      fontSize: Get.width / 28,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: greyColor,
            size: Get.width / 15,
          ),
          hint: Text(
            widget.hintText,
            style: TextStyle(fontSize: Get.width / 30, color: greyColor80),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: whiteColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            enabledBorder: EnabledBorder(),
            focusedBorder: FocusedBorder(),
            errorBorder: ErrorBorder(),
            focusedErrorBorder: FocusedBorder(),
          ),
          elevation: 1,
          validator: (value) {
            if (!widget.validationRequired) {
              return null;
            }
            if (value == null || value.isEmpty) {
              return widget.validatorText;
            }
            return null;
          },
          isExpanded: true,
          value: dropdownValue, // Use the local state value
          items:
              widget.dropdownList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              dropdownValue = value;
              widget.onChanged(value); // Notify parent widget of change
            });
          },
        ),
      ],
    );
  }
}

class RadioOptionDropdown extends StatefulWidget {
  final String LabelText, hintText, validatorText;
  final List<String> items;
  final String? initialValue;
  final Function(String) onSelectionChanged;
  final bool validationRequired;

  const RadioOptionDropdown({
    required this.LabelText,
    required this.hintText,
    required this.validatorText,
    required this.items,
    this.initialValue,
    required this.onSelectionChanged,
    this.validationRequired = true,
  });

  @override
  _RadioOptionDropdownState createState() => _RadioOptionDropdownState();
}

class _RadioOptionDropdownState extends State<RadioOptionDropdown> {
  String? _selectedItem;
  bool isDropdownOpened = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant RadioOptionDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {
        _selectedItem = widget.initialValue;
      });
    }
  }

  void _toggleDropdown() {
    setState(() {
      isDropdownOpened = !isDropdownOpened;
    });
  }

  void _onItemSelected(String item) {
    setState(() {
      _selectedItem = item;
      isDropdownOpened = false;
    });
    widget.onSelectionChanged(item);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: _selectedItem,
      validator: (value) {
        if (!widget.validationRequired) {
          return null;
        }
        if (_selectedItem == null) {
          return widget.validatorText;
        }
        return null;
      },
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.LabelText,
                  style: TextStyle(
                    fontSize: Get.width / 28,
                    letterSpacing: .5,
                    fontWeight: FontWeight.w600,
                    color: blackColor,
                  ),
                ),
                const SizedBox(width: 5),
                widget.validationRequired
                    ? Text(
                        "*",
                        style: TextStyle(
                          fontSize: Get.width / 28,
                          letterSpacing: .5,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _toggleDropdown,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: field.hasError ? Colors.red : greyColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width / 1.4,
                      child: Text(
                        _selectedItem ?? widget.hintText,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: _selectedItem != null
                                ? blackColor
                                : greyColor80,
                            letterSpacing: .5,
                            fontSize: Get.width / 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      isDropdownOpened
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: greyColor,
                      size: Get.width / 15,
                    ),
                  ],
                ),
              ),
            ),
            if (isDropdownOpened)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: greyColor40, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: Get.height / 3,
                  child: Scrollbar(
                    thumbVisibility: true,
                    radius: const Radius.circular(10),
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.items.map((item) {
                          return RadioListTile<String>(
                            visualDensity: VisualDensity.compact,
                            contentPadding: const EdgeInsets.all(0),
                            value: item,
                            groupValue: _selectedItem,
                            activeColor: kPrimaryColor,
                            title: Text(item),
                            onChanged: (value) {
                              if (value != null) {
                                _onItemSelected(value);
                                field.didChange(
                                    value); // Notify the form of the selection change
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 10),
                child: Text(
                  field.errorText!,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 13,
                          fontWeight: FontWeight.w400)),
                ),
              ),
          ],
        );
      },
    );
  }
}
