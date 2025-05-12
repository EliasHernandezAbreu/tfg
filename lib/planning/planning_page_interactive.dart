import 'package:flutter/material.dart';
import 'package:tfg/custom/labeled_column.dart';
import 'package:tfg/custom/named_box.dart';
import 'package:tfg/global_state.dart';
import 'package:tfg/planning/planning_context.dart';

class PlanningPageInteractive extends StatefulWidget {
  final void Function() backFunction;

  const PlanningPageInteractive({
    super.key,
    required this.backFunction,
  });

  @override
  State<StatefulWidget> createState() => _PlanningPageInteractive();
}

class _PlanningPageInteractive extends State<PlanningPageInteractive> {
  PlanningContext planningContext = PlanningContext(GlobalState.processes);

  void handleDropdownSelected(int? index) {
    setState(() {
      GlobalState.currentPlanningAlgorithm = index!;
    });
  }

  void simulationStep() {
    setState(() {
      var currAlgo = GlobalState.planningAlgorithms[GlobalState.currentPlanningAlgorithm].$2;
      planningContext = currAlgo.nextState(planningContext);
    });
  }

  void restartSimulation() {
    setState(() {
      planningContext = PlanningContext(GlobalState.processes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: widget.backFunction,
                  icon: const Icon(Icons.arrow_back),
                ),
                const Text("Back"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Restart"),
                IconButton(
                  onPressed: restartSimulation,
                  icon: const Icon(Icons.restore),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 4, color: Colors.black38),
            ),
            child: Container(
              decoration: const BoxDecoration(),
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time: ${planningContext.currentTime < 0 ? "NOT STARTED" : planningContext.currentTime}",
                    style: const TextStyle(fontWeight: FontWeight.bold) 
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabeledColumn(label: "Pending enter", children: [
                            ...planningContext.pendingEnter.map((p) {
                              return NamedBox(
                                name: p.key.toString(),
                                label: p.remainingTime.toString(),
                                key: Key(p.key.toString()),
                              );
                            })
                          ]),
                          LabeledColumn(label: "Ready", children: [
                            ...planningContext.ready.map((p) {
                              return NamedBox(
                                name: p.key.toString(),
                                label: p.remainingTime.toString(),
                                key: Key(p.key.toString()),
                              );
                            })
                          ]),
                          const SizedBox(width: 5),
                          LabeledColumn(label: "Executing", children: planningContext.hasCurrentProcess()
                            ? [ NamedBox(
                                name: planningContext.currentProcess!.key.toString(),
                                label: planningContext.currentProcess!.remainingTime.toString(),
                                key: Key(planningContext.currentProcess!.key.toString()),
                              ) ]
                            : [],
                          ),
                          const SizedBox(width: 5),
                          LabeledColumn(label: "Completed", children: [
                            ...planningContext.completed.map((p) {
                              return NamedBox(
                                name: p.key.toString(),
                                label: p.remainingTime.toString(),
                                key: Key(p.key.toString()),
                              );
                            })
                          ]),
                        ],
                      ),
                    )
                  )
                ],
              ),
            )
          ),
        ),
        DropdownMenu(
          onSelected: handleDropdownSelected,
          initialSelection: GlobalState.currentPlanningAlgorithm,
          dropdownMenuEntries: [
            ...GlobalState.planningAlgorithms.indexed.map((entry) {
              int index = entry.$1;
              var algoDef = entry.$2;
              return DropdownMenuEntry(value: index, label: algoDef.$1);
            })
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
