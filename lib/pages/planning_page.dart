import 'package:flutter/material.dart';
import 'package:tfg/planning_process_list.dart';

class PlanningPage extends StatelessWidget {
  const PlanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PlanningProcessList()
      ],
    );
  }
}

