import 'package:tfg/replacement/replacement_algorithm.dart';
import 'package:tfg/replacement/replacement_context.dart';

class ReplacementFifo extends ReplacementAlgorithm {
  @override
  ReplacementContext nextState(ReplacementContext oldState, int newPage) {
    ReplacementContext newState = ReplacementContext.from(oldState);
    newState.tickTime();

    if (oldState.frames.contains(newPage)) {
      newState.hits += 1;
      newState.lastWasHit = true;
      newState.lastImportant = oldState.frames.indexOf(newPage);
    } else {
      newState.failures += 1;
      newState.lastWasHit = false;
      int oldestFrame = 0;
      int oldestFrameAge = 0;
      for (int i = 0; i < newState.frameAges.length; i++) {
        if (newState.frameAges[i] > oldestFrameAge) {
          oldestFrame = i;
          oldestFrameAge = newState.frameAges[i];
        }
      }
      newState.lastImportant = oldestFrame;
      newState.frames[oldestFrame] = newPage;
      newState.frameAges[oldestFrame] = 0;
    }

    return newState;
  }
}
