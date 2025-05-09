import 'package:flutter/material.dart';
import 'package:tfg/custom/number_input.dart';
import 'package:tfg/global_state.dart';

class ReplacementSimulation extends StatefulWidget {
  const ReplacementSimulation({super.key});

  @override
  State<StatefulWidget> createState() => _ReplacementSimulation();
}

class _ReplacementSimulation extends State<ReplacementSimulation> {
  void handleDropdownSelected(int? newAlgoIndex) {
  }

  void handleNumberInputChange(int value) {
  }

  void handleButtonClick() {
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 4, color: Colors.black38),
            ),
          )
        ),
        DropdownMenu(
          onSelected: handleDropdownSelected,
          initialSelection: GlobalState.currentReplacementAlgorithm,
          dropdownMenuEntries: [
            ...GlobalState.replacementAlgorithms.indexed.map((entry) {
              int index = entry.$1;
              var algoDef = entry.$2;
              return DropdownMenuEntry(value: index, label: algoDef.$1);
            })
          ]
        ),
        Row(
          children: [
            NumberInput(onChanged: handleNumberInputChange),
            ElevatedButton(
              onPressed: handleButtonClick,
              child: const Icon(Icons.pages),
            )
          ],
        ),
      ],
    );
  }
}
