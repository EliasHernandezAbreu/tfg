import 'package:tfg/planning/planning_algorithm.dart';
import 'package:tfg/planning/planning_context.dart';

class PlanningFcfs extends PlanningAlgorithm {
  @override
  PlanningContext nextState(PlanningContext oldState) {
    PlanningContext newState = PlanningContext.from(oldState);
    newState.tickTime();
    newState.burstCpu();

    if (newState.currentProcess == null && newState.ready.isNotEmpty) {
      newState.moveToCpu(newState.ready.first);
    }

    return newState;
  }
}
