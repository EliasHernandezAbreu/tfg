import 'package:tfg/planning/algorithms/planning_fcfs.dart';
import 'package:tfg/planning/algorithms/planning_ljf.dart';
import 'package:tfg/planning/algorithms/planning_lrtf.dart';
import 'package:tfg/planning/algorithms/planning_prio.dart';
import 'package:tfg/planning/algorithms/planning_rr.dart';
import 'package:tfg/planning/algorithms/planning_sjf.dart';
import 'package:tfg/planning/algorithms/planning_srtf.dart';
import 'package:tfg/planning/cpu_process.dart';

import 'package:tfg/replacement/algorithms/replacement_fifo.dart';
import 'package:tfg/replacement/algorithms/replacement_lru.dart';
import 'package:tfg/replacement/algorithms/replacement_mru.dart';

abstract class GlobalState {
  static var planningAlgorithms = [
    ("FCFS", PlanningFcfs(), "First come, first served"),
    ("SJF", PlanningSjf(), "Shortest job first"),
    ("LJF", PlanningLjf(), "Longest job first"),
    ("SRTF", PlanningSrtf(), "Shortest remaining time first"),
    ("LRTF", PlanningLrtf(), "Longest remaining time first"),
    ("PRIO-P", PlanningPrio(true), "Priority algorithm (preemptive)"),
    ("PRIO-N", PlanningPrio(false), "Priority algorithm (non-preemptive)"),
    ("RR", PlanningRr(), "Round Robin"),
  ];
  static List<CpuProcess> processes = [CpuProcess(0, 1, 3)]; // List of processes
  static int currentPlanningAlgorithm = 0; // As index of planning algorithms
  static int planningRRTime = 3; // Time between round robin cycles

  static var replacementAlgorithms = [
    ("FIFO", ReplacementFifo(), "First in, first out"),
    ("LRU", ReplacementLru(), "Least recently used"),
    ("MRU", ReplacementMru(), "Most recently used"),
  ];
  static int currentReplacementAlgorithm = 0; // As index of replacement algorithms
  static int replacementFrameAmount = 3;

  static bool darkMode = false;
}
