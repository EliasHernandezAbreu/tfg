import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg/custom/number_input.dart';
import 'package:tfg/planning/cpu_process.dart';

class PlanningProcessList extends StatelessWidget {
  final List<CpuProcess> processes;
  final Function() addProcess;
  final Function(int index) removeProcess;
  final Function(int index, int value) changeProcessEnterTime;
  final Function(int index, int value) changeProcessTimeToComplete;

  const PlanningProcessList({
    super.key,
    required this.processes,
    required this.addProcess,
    required this.removeProcess,
    required this.changeProcessEnterTime,
    required this.changeProcessTimeToComplete,
  });

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
        Table(
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
            ...processes.indexed.map(processRow),
          ]
        ),
      ],
    );
  }
}
