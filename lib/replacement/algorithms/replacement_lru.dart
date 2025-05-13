import 'package:tfg/replacement/replacement_algorithm.dart';
import 'package:tfg/replacement/replacement_context.dart';

class ReplacementLru extends ReplacementAlgorithm {
  @override
  ReplacementContext nextState(ReplacementContext oldState, int newPage) {
    ReplacementContext newState = ReplacementContext.from(oldState);
    newState.tickTime();

    int index = newState.checkPage(newPage);
    if (index < 0) {
      int oldestFrame = 0;
      int oldestFrameAge = 0;
      for (int i = 0; i < newState.useRecency.length; i++) {
        if (newState.useRecency[i] > oldestFrameAge) {
          oldestFrame = i;
          oldestFrameAge = newState.useRecency[i];
        }
      }
      newState.replacePage(oldestFrame, newPage);
    }

    return newState;
  }
}

