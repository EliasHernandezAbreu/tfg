import 'package:tfg/planning/cpu_process.dart';
import 'package:tfg/planning/planning_algorithm.dart';
import 'package:tfg/planning/planning_context.dart';

class PlanningLrtf extends PlanningAlgorithm {
  @override
  PlanningContext nextState(PlanningContext oldState) {
    PlanningContext newState = PlanningContext.from(oldState);
    newState.tickTime();
    newState.burstCpu();

    CpuProcess? longestProcess = newState.currentProcess;
    for (CpuProcess currentProcess in newState.ready) {
      if (longestProcess == null || currentProcess.remainingTime > longestProcess.remainingTime) {
        longestProcess = currentProcess;
      }
    }
    longestProcess != null && newState.moveToCpu(longestProcess);

    return newState;
  }
}

