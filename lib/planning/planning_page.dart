import 'package:flutter/material.dart';
import 'package:tfg/planning/planning_page_config.dart';
import 'package:tfg/planning/planning_page_interactive.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PlanningPageState();
  }
}

class _PlanningPageState extends State<PlanningPage> {
  int currentPage = 0;

  void setConfigPage() {
    setState(() {
      currentPage = 0;
    });
  }
  void setInteractivePage() {
    setState(() {
      currentPage = 1;
    });
  }
  void setStaticPage() {
    setState(() {
      currentPage = 2;
    });
  }

  Widget decidePageBody() {
    switch (currentPage) {
      case 0: return PlanningPageConfig(
        startInteractiveSimulation: setInteractivePage,
        startStaticSimulation: setStaticPage,
      );
      case 1: return PlanningPageInteractive(
        backFunction: setConfigPage
      );
      default: return const Text("Uhh");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24) ,
      child: decidePageBody()
    );
  }
}
