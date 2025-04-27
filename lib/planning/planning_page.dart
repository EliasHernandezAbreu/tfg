import 'package:flutter/material.dart';
import 'package:tfg/planning/cpu_process.dart';
import 'package:tfg/planning/algorithms/planning_fifo.dart';
import 'package:tfg/planning/planning_algorithm.dart';
import 'package:tfg/planning/planning_context.dart';
import 'package:tfg/planning/planning_process_list.dart';
import 'package:tfg/planning/planning_simulation.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PlanningPageState();
  }
}

class _PlanningPageState extends State<PlanningPage> {
  int pageSimulationStep = 0;
  PlanningContext _context = PlanningContext([]);
  PlanningAlgorithm _algorithm = PlanningFifo();
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

  void clickedElevatedButton() {
    setState(() {
      if (pageSimulationStep == 0) {
        pageSimulationStep = 1;
        _context = PlanningContext(_processes);
        return;
      }
      if (pageSimulationStep == 1) { pageSimulationStep = 0; return; }

    });
  }

  void tickTime() {
    setState(() {
      PlanningContext newContext = _algorithm.nextState(_context);
      _context = newContext;
    });
  }

  void changeAlgorithm(PlanningAlgorithm newAlgorithm) {
    setState(() {
      _algorithm = newAlgorithm;
    });
  }

  Widget getFloatingButton() {
    if (pageSimulationStep == 0) {
      return FloatingActionButton.extended(
        onPressed: clickedElevatedButton,
        label: const Text("Start simulation"),
        icon: const Icon(Icons.pie_chart),
      );
    } else if (pageSimulationStep == 1) {
      return FloatingActionButton.extended(
        onPressed: clickedElevatedButton,
        label: const Text("Exit simulation"),
        icon: const Icon(Icons.pie_chart),
      );
    } else {
      return FloatingActionButton.extended(
        onPressed: clickedElevatedButton,
        label: const Text("GET OUT"),
        icon: const Icon(Icons.pie_chart),
      );
    }
  }

  Widget decidePageBody() {
    if (pageSimulationStep == 0) {
      return PlanningProcessList(
        processes: _processes,
        addProcess: addProcess,
        removeProcess: removeProcess,
        changeProcessEnterTime: changeProcessEnterTime,
        changeProcessTimeToComplete: changeProcessTimeToComplete,
      );
    } else if (pageSimulationStep == 1) {
      return PlanningSimulation(
        algorithm: _algorithm,
        planningContext: _context,
        simulationStep: tickTime,
        changeAlgorithm: changeAlgorithm,
      );
    } else {
      return const Text("You're not supposed to be here btw");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24) ,
      child: Scaffold(
        body: decidePageBody(),
        floatingActionButton: getFloatingButton()
      )
    );
  }
}
