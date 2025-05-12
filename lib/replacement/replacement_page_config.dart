import 'package:flutter/material.dart';
import 'package:tfg/global_state.dart';

class ReplacementPageConfig extends StatefulWidget {
  final void Function() startInteractiveSimulation;
  final void Function() startStaticSimulation;

  const ReplacementPageConfig({
    super.key,
    required this.startInteractiveSimulation,
    required this.startStaticSimulation,
  });

  @override
  State<StatefulWidget> createState() => _ReplacementPageConfig();
}

class _ReplacementPageConfig extends State<ReplacementPageConfig> {
  void handleDropdownSelected(int? newAlgo) {
    GlobalState.currentPlanningAlgorithm = newAlgo!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownMenu(
          onSelected: handleDropdownSelected,
          initialSelection: GlobalState.currentPlanningAlgorithm,
          dropdownMenuEntries: [
            ...GlobalState.replacementAlgorithms.indexed.map((entry) {
              int index = entry.$1;
              var algoDef = entry.$2;
              return DropdownMenuEntry(value: index, label: algoDef.$1);
            })
          ]
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Static",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(),
            Row(children: [
              ElevatedButton.icon(
                onPressed: widget.startStaticSimulation,
                label: const Text("Start static simulation")),
            ])
          ],
        ),
        Container(
          color: Colors.blue,
          height: 2,
          margin: const EdgeInsets.symmetric(vertical: 24),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Interactive",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(children: [
              ElevatedButton.icon(
                onPressed: widget.startInteractiveSimulation,
                label: const Text("Start interactive simulation")),
            ])
          ],
        ),
      ],
    );
  }
}
