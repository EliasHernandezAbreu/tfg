import 'package:tfg/cpu_process.dart';
import 'package:tfg/planning/planning_algorithm.dart';
import 'package:tfg/planning/planning_context.dart';

class PlanningSjf extends PlanningAlgorithm {
  @override
  PlanningContext nextState(PlanningContext oldState) {
    PlanningContext newState = PlanningContext.from(oldState);
    newState.tickTime();

    CpuProcess? shortestProcess;
    if (newState.currentProcess != null) {
      shortestProcess = oldState.currentProcess!;
    }
    for (CpuProcess currentProcess in newState.ready) {
      if (shortestProcess == null || currentProcess.remainingTime < shortestProcess.remainingTime) {
        shortestProcess = currentProcess;
      }
    }
    shortestProcess != null && newState.moveToCpu(shortestProcess);
    return newState;
  }
}

