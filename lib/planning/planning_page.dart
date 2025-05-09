import 'package:flutter/material.dart';
import 'package:tfg/global_state.dart';
import 'package:tfg/planning/cpu_process.dart';
import 'package:tfg/planning/planning_algorithm.dart';
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
  int currentPlanningPage = 0;

  void clickedElevatedButton() {
    setState(() {
      if (currentPlanningPage == 0) {
        currentPlanningPage = 1;
        return;
      }
      if (currentPlanningPage == 1) {
        currentPlanningPage = 0;
        return;
      }
    });
  }

  Widget getFloatingButton() {
    if (currentPlanningPage == 0) {
      return FloatingActionButton.extended(
        onPressed: clickedElevatedButton,
        label: const Text("Start simulation"),
        icon: const Icon(Icons.pie_chart),
      );
    } else if (currentPlanningPage == 1) {
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
    if (currentPlanningPage == 0) {
      return const PlanningProcessList();
    } else if (currentPlanningPage == 1) {
      return const PlanningSimulation();
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
