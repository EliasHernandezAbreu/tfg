import 'package:tfg/global_state.dart';
import 'package:tfg/planning/planning_algorithm.dart';
import 'package:tfg/planning/planning_context.dart';

class PlanningRr extends PlanningAlgorithm {
  @override
  PlanningContext nextState(PlanningContext oldState) {
    PlanningContext newState = PlanningContext.from(oldState);
    newState.tickTime();
    newState.burstCpu();

    bool shouldSwap = newState.timeSinceLastSwap >= GlobalState.planningRRTime;
    shouldSwap = shouldSwap || newState.currentProcess == null;
    shouldSwap = shouldSwap && newState.ready.isNotEmpty;
    if (shouldSwap) {
      newState.moveToCpu(newState.ready.first);
    }

    return newState;
  }
}

