import 'package:flutter/material.dart';
import 'package:tfg/replacement/algorithms/replacement_fifo.dart';
import 'package:tfg/replacement/replacement_algorithm.dart';
import 'package:tfg/replacement/replacement_context.dart';

class ReplacementPage extends StatefulWidget {
  const ReplacementPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ReplacementPageState();
  }
}

class _ReplacementPageState extends State<ReplacementPage> {
  int _pageFrames = 1;
  final ReplacementAlgorithm _algorithm = ReplacementFifo();
  ReplacementContext _context = ReplacementContext(4);

  void nextStep() {
    setState(() {
      _context = _algorithm.nextState(_context, 0);
    });
  }
  
  void startSimulation() {
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Planned",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(),
              Row(children: [
                ElevatedButton.icon(
                  onPressed: startSimulation,
                  label: const Text("yea")),
                const DropdownMenu(
                  initialSelection: 0,
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 0, label: "fifo"),
                    DropdownMenuEntry(value: 1, label: "optimal"),
                    DropdownMenuEntry(value: 2, label: "lru"),
                    DropdownMenuEntry(value: 3, label: "mru"),
                  ]
                )

              ])
            ],
          ),
          Container(
            color: Colors.blue,
            height: 2,
            margin: const EdgeInsets.symmetric(vertical: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Interactive",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(children: [
                ElevatedButton.icon(
                  onPressed: startSimulation,
                  label: const Text("yea")),
                const DropdownMenu(
                  initialSelection: 0,
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 0, label: "fifo"),
                    DropdownMenuEntry(value: 2, label: "lru"),
                    DropdownMenuEntry(value: 3, label: "mru"),
                  ]
                )

              ])
            ],
          ),
        ],
      ),
    );
  }
}
