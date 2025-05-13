import 'package:tfg/replacement/replacement_algorithm.dart';
import 'package:tfg/replacement/replacement_context.dart';

class ReplacementFifo extends ReplacementAlgorithm {
  @override
  ReplacementContext nextState(ReplacementContext oldState, int newPage) {
    ReplacementContext newState = ReplacementContext.from(oldState);
    newState.tickTime();

    int index = newState.checkPage(newPage);
    if (index < 0) {
      int oldestFrame = 0;
      int oldestFrameAge = 0;
      for (int i = 0; i < newState.frameAges.length; i++) {
        if (newState.frameAges[i] > oldestFrameAge) {
          oldestFrame = i;
          oldestFrameAge = newState.frameAges[i];
        }
      }
      newState.replacePage(oldestFrame, newPage);
    }

    return newState;
  }
}
