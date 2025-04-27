import 'package:tfg/planning/planning_algorithm.dart';
import 'package:tfg/planning/planning_context.dart';

class PlanningFifo extends PlanningAlgorithm {
  @override
  PlanningContext nextState(PlanningContext oldState) {
    PlanningContext newState = PlanningContext.from(oldState);
    newState.tickTime();

    if (newState.ready.isEmpty || newState.currentProcess != null) return newState;
    newState.moveToCpu(newState.ready.first);
    return newState;
  }
}
