import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatelessWidget {
  final int initialValue;
  final void Function(int newValue) onChanged;

  final TextEditingController controller = TextEditingController();

  NumberInput({
    super.key,
    required this.onChanged,
    this.initialValue = 0,
  }) {
    controller.text = initialValue.toString();
    controller.selection = TextSelection.collapsed(offset: controller.text.length);
    print(controller.text);
  }

  void selectAllText() {
    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller.value.text.length
    );
  }

  void handleChange(String newValue) {
    int? numValue = int.tryParse(newValue);
    if (numValue == null) {
      controller.text = initialValue.toString();
      return;
    }
    controller.text = numValue.toString();
    onChanged(numValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: handleChange,
      onTap: selectAllText,
    );
  }
}

