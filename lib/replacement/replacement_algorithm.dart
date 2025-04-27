import 'package:tfg/replacement/replacement_context.dart';

abstract class ReplacementAlgorithm {
  ReplacementContext nextState(ReplacementContext oldState, int newPage);
}

