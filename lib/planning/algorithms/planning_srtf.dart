import 'package:tfg/planning/cpu_process.dart';
import 'package:tfg/planning/planning_algorithm.dart';
import 'package:tfg/planning/planning_context.dart';

class PlanningSrtf extends PlanningAlgorithm {
  @override
  PlanningContext nextState(PlanningContext oldState) {
    PlanningContext newState = PlanningContext.from(oldState);
    newState.tickTime();
    newState.burstCpu();

    CpuProcess? shortestProcess = newState.currentProcess;
    for (CpuProcess currentProcess in newState.ready) {
      if (shortestProcess == null || currentProcess.remainingTime < shortestProcess.remainingTime) {
        shortestProcess = currentProcess;
      }
    }
    shortestProcess != null && newState.moveToCpu(shortestProcess);

    return newState;
  }
}

