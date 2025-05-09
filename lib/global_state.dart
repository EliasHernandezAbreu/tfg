import 'package:tfg/planning/algorithms/planning_fcfs.dart';
import 'package:tfg/planning/algorithms/planning_rr.dart';
import 'package:tfg/planning/algorithms/planning_sjf.dart';
import 'package:tfg/planning/algorithms/planning_srtf.dart';
import 'package:tfg/planning/cpu_process.dart';

import 'package:tfg/replacement/algorithms/replacement_fifo.dart';
import 'package:tfg/replacement/algorithms/replacement_lru.dart';
import 'package:tfg/replacement/algorithms/replacement_mru.dart';
import 'package:tfg/replacement/algorithms/replacement_op.dart';

abstract class GlobalState {
  static var planningAlgorithms = [
    ("FCFS", PlanningFcfs(), "First come, first served"),
    ("SJF", PlanningSjf(), "Shortest job first"),
    ("SRTF", PlanningSrtf(), "Shortest remaining time first"),
    ("RR", PlanningRr(), "Round Robin"),
  ];
  static List<CpuProcess> processes = [CpuProcess(0, 1)]; // List of processes
  static int currentPlanningAlgorithm = 0; // As index of planning algorithms

  static var replacementAlgorithms = [
    ("FIFO", ReplacementFifo(), "First in, first out"),
    ("LRU", ReplacementLru(), "Least recently used"),
    ("MRU", ReplacementMru(), "Most recently used"),
    ("Op", ReplacementOp(), "Optimal"),
  ];
  static int currentReplacementAlgorithm = 0; // As index of planning algorithms
}
