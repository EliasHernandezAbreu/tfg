import 'package:flutter/material.dart';
import 'package:tfg/replacement/replacement_page_config.dart';
import 'package:tfg/replacement/replacement_page_interactive.dart';
import 'package:tfg/replacement/replacement_page_static.dart';

class ReplacementPage extends StatefulWidget {
  const ReplacementPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ReplacementPageState();
  }
}

class _ReplacementPageState extends State<ReplacementPage> {
  int currentPage = 0;

  void setConfigPage() {
    setState(() {
      currentPage = 0;
    });
  }
  void startStaticSimulation() {
    setState(() {
      currentPage = 1;
    });
  }
  void startInteractiveSimulation() {
    setState(() {
      currentPage = 2;
    });
  }

  Widget getCurrentPage() {
    switch (currentPage) {
      case 0: return ReplacementPageConfig(
        startStaticSimulation: startStaticSimulation,
        startInteractiveSimulation: startInteractiveSimulation,
      );
      case 1: return const ReplacementPageStatic();
      case 2: return ReplacementPageInteractive(
        backFunction: setConfigPage,
      );
      default: return const Text("Woops");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: getCurrentPage(),
    );
  }
}
