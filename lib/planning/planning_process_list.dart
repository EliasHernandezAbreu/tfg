import 'package:flutter/material.dart';
import 'package:tfg/custom/number_input.dart';
import 'package:tfg/global_state.dart';
import 'package:tfg/planning/cpu_process.dart';

class PlanningProcessList extends StatefulWidget {
  const PlanningProcessList({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _PlanningProcessList();
}

class _PlanningProcessList extends State<PlanningProcessList> {
  void removeProcess(int index) {
    if (GlobalState.processes.length <= 1) return;
    setState(() {
      GlobalState.processes.removeAt(index);
    });
  }

  void addProcess() {
    setState(() {
      GlobalState.processes.add(CpuProcess(0, 1));
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
      ],
    );
  }
}
