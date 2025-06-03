import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatelessWidget {
  final int initialValue;
  final int minValue;
  final int? maxValue;
  final void Function(int newValue)? onChanged;
  final void Function(int newValue)? onSubmit;

  final TextEditingController controller = TextEditingController();

  NumberInput({
    super.key,
    this.onChanged,
    this.onSubmit,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue,
  }) {
    controller.text = initialValue.toString();
    controller.selection = TextSelection.collapsed(offset: controller.text.length);
  }

  void selectAllText() {
    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller.value.text.length
    );
  }

  void handleChange(String newValue) {
    if (newValue.isEmpty) {
      controller.text = minValue.toString();
      selectAllText();
      return;
    }
    int? numValue = int.tryParse(newValue);
    if (numValue == null) {
      controller.text = initialValue.toString();
      return;
    }
    if (numValue < minValue) {
      controller.text = minValue.toString();
      onChanged?.call(minValue);
      return;
    }
    if (maxValue != null && numValue > maxValue!) {
      controller.text = maxValue.toString();
      onChanged?.call(maxValue!);
      return;
    }
    controller.text = numValue.toString();
    onChanged?.call(numValue);
  }

  void handleSubmit(String value) {
    int numValue = int.parse(value);
    onSubmit?.call(numValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: handleChange,
      onFieldSubmitted: handleSubmit,
      
      onTap: selectAllText,
    );
  }
}

