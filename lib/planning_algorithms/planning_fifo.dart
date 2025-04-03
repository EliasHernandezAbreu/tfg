import 'package:tfg/planning_algorithm.dart';
import 'package:tfg/planning_state.dart';

class PlanningFifo extends PlanningAlgorithm {
  @override
  PlanningState nextState(PlanningState oldState) {
    PlanningState newState = PlanningState.from(oldState);
    newState.tickTime();
    if (newState.ready.isEmpty || newState.currentProcess != null) return newState;
    newState.moveToCpu(newState.ready.first);
    return newState;
  }
}
