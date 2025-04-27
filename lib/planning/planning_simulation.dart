import 'package:flutter/material.dart';
import 'package:tfg/custom/labeled_column.dart';
import 'package:tfg/custom/named_box.dart';
import 'package:tfg/planning/algorithms/planning_fifo.dart';
import 'package:tfg/planning/algorithms/planning_sjf.dart';
import 'package:tfg/planning/planning_algorithm.dart';
import 'package:tfg/planning/planning_context.dart';

class PlanningSimulation extends StatelessWidget {
  final PlanningAlgorithm algorithm;
  final PlanningContext planningContext;
  final void Function(PlanningAlgorithm) changeAlgorithm;
  final Function() simulationStep;

  const PlanningSimulation({
    super.key,
    required this.algorithm,
    required this.planningContext,
    required this.changeAlgorithm,
    required this.simulationStep,
  });

  void changeAlgorithmIndex(int index) {
    switch (index) {
      case 0: 
        changeAlgorithm(PlanningFifo());
        break;
      case 1: 
        changeAlgorithm(PlanningSjf());
        break;
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(width: 4, color: Colors.black38),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabeledColumn(label: "Pending enter", children: [
                ...planningContext.pendingEnter.map((p) {
                  return NamedBox(p.key.toString(), p.remainingTime.toString());
                })
              ]),
              LabeledColumn(label: "Ready", children: [
                ...planningContext.ready.map((p) {
                  return NamedBox(p.key.toString(), p.remainingTime.toString());
                })
              ]),
              const SizedBox(width: 5),
              LabeledColumn(label: "Executing", children: planningContext.hasCurrentProcess()
                ? [ NamedBox(
                    planningContext.currentProcess!.key.toString(),
                    planningContext.currentProcess!.remainingTime.toString(),
                  ) ]
                : [],
              ),
              const SizedBox(width: 5),
              LabeledColumn(label: "Completed", children: [
                ...planningContext.completed.map((p) {
                  return NamedBox(p.key.toString(), p.remainingTime.toString());
                })
              ]),
            ],
          ),
        ),
        const DropdownMenu(
          onSelected: null,
          initialSelection: 0,
          dropdownMenuEntries: [
            DropdownMenuEntry(value: 0, label: "FIFO"),
            DropdownMenuEntry(value: 1, label: "SJF"),
          ]
        ),
        ElevatedButton(
          onPressed: simulationStep,
          child: const Icon(Icons.short_text_sharp)
        )
      ],
    );
  }
}
