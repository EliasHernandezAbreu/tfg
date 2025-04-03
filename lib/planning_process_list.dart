import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg/process.dart';

class PlanningProcessList extends StatefulWidget {
  const PlanningProcessList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PlanningProcessListState();
  }
}

class _PlanningProcessListState extends State<PlanningProcessList> {
  final List<CpuProcess> _processes = [CpuProcess(0, 1)];

  void removeProcess(int index) {
    if (_processes.length <= 1) return;
    setState(() {
      _processes.removeAt(index);
    });
  }

  void addProcess() {
    setState(() {
      _processes.add(CpuProcess(0, 1));
    });
  }

  void changeProcessEnterTime(int index, int value) {
    setState(() {
      _processes[index].enterTime = value;
    });
  }
  void changeProcessTimeToComplete(int index, int value) {
    setState(() {
      _processes[index].timeToComplete = value;
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
        TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          initialValue: process.enterTime.toString(),
          onChanged: (value) { changeProcessEnterTime(index, int.parse(value)); },
        ),
        TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          initialValue: process.timeToComplete.toString(),
          onChanged: (value) { changeProcessTimeToComplete(index, int.parse(value)); },
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
            ..._processes.indexed.map(processRow),
          ]
        ),
      ],
    );
  }
}

