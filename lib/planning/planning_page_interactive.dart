import 'package:flutter/material.dart';
import 'package:tfg/custom/labeled_column.dart';
import 'package:tfg/custom/number_input.dart';
import 'package:tfg/global_state.dart';
import 'package:tfg/planning/cpu_process_view.dart';
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

  void stepToEnd() {
    setState(() {
      var currAlgo = GlobalState.planningAlgorithms[GlobalState.currentPlanningAlgorithm].$2;
      while (!planningContext.finished) {
        planningContext = currAlgo.nextState(planningContext);
      }
    });
  }

  void restartSimulation() {
    setState(() {
      planningContext = PlanningContext(GlobalState.processes);
    });
  }

  void changeRrTime(int? value) {
    setState(() {
      GlobalState.planningRRTime = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    bool smallScreen = screenWidth < 500;

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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: screenWidth < 500 ? 400 : screenWidth - 100,
                decoration: const BoxDecoration(),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Time: ${planningContext.currentTime < 0 ?
                                "NOT STARTED" : planningContext.finished ?
                                  "FINISHED" : planningContext.currentTime}",
                              style: const TextStyle(fontWeight: FontWeight.bold) 
                            ),
                            Text(
                              "Time since last swap: ${planningContext.timeSinceLastSwap}",
                              style: const TextStyle(fontWeight: FontWeight.bold) 
                            ),
                          ],
                        ),
                        Visibility(
                          visible: planningContext.finished,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Average turn around time: ${planningContext.averageTurnAroundTime.toStringAsFixed(2)}",
                                style: const TextStyle(fontWeight: FontWeight.bold) 
                              ),
                              Text(
                                "Average waiting time: ${planningContext.averageWaitingTime.toStringAsFixed(2)}",
                                style: const TextStyle(fontWeight: FontWeight.bold) 
                              ),
                            ],
                          )
                        ),
                      ],
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
                                return CpuProcessView(
                                  key: GlobalObjectKey(p.key!),
                                  process: p,
                                  mainElement: CpuProcessViewMainElement.enterTime,
                                );
                              })
                            ]),
                            LabeledColumn(label: "Ready", children: [
                              ...planningContext.ready.map((p) {
                                return CpuProcessView(
                                  key: GlobalObjectKey(p.key!),
                                  process: p,
                                  mainElement: CpuProcessViewMainElement.remainingTime,
                                );
                              })
                            ]),
                            const SizedBox(width: 5),
                            LabeledColumn(label: "Executing", children: planningContext.hasCurrentProcess()
                              ? [
                                  CpuProcessView(
                                    key: GlobalObjectKey(planningContext.currentProcess!.key!),
                                    process: planningContext.currentProcess!,
                                    mainElement: CpuProcessViewMainElement.remainingTime,
                                  )
                                ]
                              : [],
                            ),
                            const SizedBox(width: 5),
                            LabeledColumn(label: "Completed", children: [
                              ...planningContext.completed.map((p) {
                                return CpuProcessView(
                                  key: GlobalObjectKey(p.key!),
                                  process: p,
                                  mainElement: CpuProcessViewMainElement.completionTime,
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
        const SizedBox(height: 20),
        Row( // 6 is Round Robin index
          children: [
            Expanded(
              flex: 3,
              child: Container()
            ),
            Expanded(
              flex: smallScreen ? 16 : 4,
              child: Column(
                children: [
                  if (GlobalState.currentPlanningAlgorithm == 6) Row(
                    children: [
                      const Text("Round Robin time:"),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 3,
                        child: NumberInput(
                          onChanged: changeRrTime,
                          initialValue: GlobalState.planningRRTime,
                          minValue: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: simulationStep,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.short_text),
                        SizedBox(width: 10),
                        Text("STEP"),
                      ],
                    )
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: stepToEnd,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.textsms),
                        SizedBox(width: 10),
                        Text("STEP TO END"),
                      ],
                    )
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container()
            ),
          ],
        ),
      ],
    );
  }
}
