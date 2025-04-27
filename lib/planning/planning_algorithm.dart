import 'package:tfg/planning/planning_context.dart';

abstract class PlanningAlgorithm {
  PlanningContext nextState(PlanningContext oldState);
}
