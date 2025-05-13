import 'package:tfg/planning/cpu_process.dart';
import 'package:tfg/planning/planning_algorithm.dart';
import 'package:tfg/planning/planning_context.dart';

class PlanningLjf extends PlanningAlgorithm {
  @override
  PlanningContext nextState(PlanningContext oldState) {
    PlanningContext newState = PlanningContext.from(oldState);
    newState.tickTime();
    newState.burstCpu();

    if (newState.currentProcess == null) {
      CpuProcess? longestProcess;
      for (CpuProcess currentProcess in newState.ready) {
        if (longestProcess == null || currentProcess.remainingTime > longestProcess.remainingTime) {
          longestProcess = currentProcess;
        }
      }
      longestProcess != null && newState.moveToCpu(longestProcess);
    }

    return newState;
  }
}


