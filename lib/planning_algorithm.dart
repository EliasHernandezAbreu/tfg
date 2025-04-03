import 'package:tfg/planning_state.dart';

abstract class PlanningAlgorithm {
  PlanningState nextState(PlanningState oldState);
}
