import 'package:tfg/planning_context.dart';

abstract class PlanningAlgorithm {
  PlanningContext nextState(PlanningContext oldState);
}
