import 'package:tfg/replacement/replacement_algorithm.dart';
import 'package:tfg/replacement/replacement_context.dart';

class ReplacementFifo extends ReplacementAlgorithm {
  @override
  ReplacementContext nextState(ReplacementContext oldState, int newPage) {
    ReplacementContext newState = ReplacementContext.from(oldState);

    if (oldState.frames.contains(newPage)) {
      newState.hits += 1;
    } else {
      newState.failures += 1;
      newState.frames.insert(0, newPage);
      newState.frames.removeLast();
    }

    return newState;
  }
}
