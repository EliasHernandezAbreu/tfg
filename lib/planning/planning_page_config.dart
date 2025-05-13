import 'package:flutter/material.dart';
import 'package:tfg/custom/number_input.dart';
import 'package:tfg/global_state.dart';
import 'package:tfg/planning/cpu_process.dart';

class PlanningPageConfig extends StatefulWidget {
  final void Function() startInteractiveSimulation;
  final void Function() startStaticSimulation;

  const PlanningPageConfig({
    super.key,
    required this.startInteractiveSimulation,
    required this.startStaticSimulation,
  });

  @override
  State<StatefulWidget> createState() => _PlanningPageConfig();
}

class _PlanningPageConfig extends State<PlanningPageConfig> {
  void removeProcess(int index) {
    if (GlobalState.processes.length <= 1) return;
    setState(() {
      GlobalState.processes.removeAt(index);
    });
  }

  void addProcess() {
    setState(() {
      GlobalState.processes.add(CpuProcess(0, 1, 3));
    });
  }

  void changeProcessEnterTime(int index, int value) {
    setState(() {
      GlobalState.processes[index].enterTime = value;
    });
  }
  void changeProcessTimeToComplete(int index, int value) {
    setState(() {
      GlobalState.processes[index].timeToComplete = value;
    });
  }
  void changeProcessPriority(int index, int value) {
    setState(() {
      GlobalState.processes[index].priority = value;
    });
  }

  TableRow processRow((int, CpuProcess) pair) {
    int index = pair.$1;
    CpuProcess process = pair.$2;
    return TableRow(
      key: ObjectKey(process),
      children: [
        Focus(
          skipTraversal: true,
          descendantsAreFocusable: false,
          descendantsAreTraversable: false,
          child: IconButton(
            onPressed: () { removeProcess(index); },
            icon: const Icon(Icons.remove_circle_outline),
            focusNode: null,
          ),
        ),
        Text(index.toString(), textAlign: TextAlign.center),
        NumberInput(
          onChanged: (value) { changeProcessEnterTime(index, value); },
          initialValue: process.enterTime,
        ),
        NumberInput(
          onChanged: (value) { changeProcessTimeToComplete(index, value); },
          initialValue: process.timeToComplete,
          minValue: 1,
        ),
        NumberInput(
          onChanged: (value) { changeProcessPriority(index, value); },
          initialValue: process.priority,
          minValue: 1,
        ),
      ]
    );
  }

  TableRow header() {
    return TableRow(
      children: [
        IconButton(onPressed: addProcess, icon: const Icon(Icons.add_box)),
        const Text('Index', textAlign: TextAlign.center),
        const Text('Enter time', textAlign: TextAlign.center),
        const Text('Time to complete', textAlign: TextAlign.center),
        const Tooltip(
          message: "Lower number represents higher priority",
          child: Text('Priority', textAlign: TextAlign.center),
        ) 
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Processes'),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Table(
                border: const TableBorder(
                  horizontalInside: BorderSide(),
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FixedColumnWidth(64),
                  1: FixedColumnWidth(64),
                },
                children: [
                  header(),
                  ...GlobalState.processes.indexed.map(processRow),
                ]
              ),
            ),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownMenu(
              onSelected: (int? algo) { GlobalState.currentPlanningAlgorithm = algo!; },
              initialSelection: GlobalState.currentPlanningAlgorithm,
              dropdownMenuEntries: [
                ...GlobalState.planningAlgorithms.indexed.map((entry) {
                  int index = entry.$1;
                  var algoDef = entry.$2;
                  return DropdownMenuEntry(value: index, label: algoDef.$1);
                })
              ]
            ),
            const SizedBox(width: 30),
            Column(
              children: [
                ElevatedButton(
                  onPressed: widget.startStaticSimulation,
                  child: const Text("Start static simulation"),
                ),
                ElevatedButton(
                  onPressed: widget.startInteractiveSimulation,
                  child: const Text("Start interactive simulation"),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}


