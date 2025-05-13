import 'package:tfg/planning/cpu_process.dart';
import 'package:tfg/planning/planning_algorithm.dart';
import 'package:tfg/planning/planning_context.dart';

class PlanningPrio extends PlanningAlgorithm {
  @override
  PlanningContext nextState(PlanningContext oldState) {
    PlanningContext newState = PlanningContext.from(oldState);
    newState.tickTime();
    newState.burstCpu();

    if (newState.currentProcess == null) {
      CpuProcess? priorityProcess;
      for (CpuProcess currentProcess in newState.ready) {
        if (priorityProcess == null || currentProcess.priority < priorityProcess.priority) {
          priorityProcess = currentProcess;
        }
      }
      priorityProcess != null && newState.moveToCpu(priorityProcess);
    }

    return newState;
  }
}


