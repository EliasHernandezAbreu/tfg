import 'package:tfg/replacement/replacement_algorithm.dart';
import 'package:tfg/replacement/replacement_context.dart';

class ReplacementMru extends ReplacementAlgorithm {
  @override
  ReplacementContext nextState(ReplacementContext oldState, int newPage) {
    ReplacementContext newState = ReplacementContext.from(oldState);
    newState.tickTime();

    if (oldState.frames.contains(newPage)) {
      newState.hits += 1;
      newState.lastWasHit = true;
      newState.lastImportant = oldState.frames.indexOf(newPage);
      newState.frameAges[newState.lastImportant!] = 0;
    } else {
      newState.failures += 1;
      newState.lastWasHit = false;
      int youngestFrame = 0;
      int youngestFrameAge = 0;
      for (int i = 0; i < newState.frameAges.length; i++) {
        if (newState.frameAges[i] < youngestFrameAge) {
          youngestFrame = i;
          youngestFrameAge = newState.frameAges[i];
        }
      }
      newState.lastImportant = youngestFrame;
      newState.frames[youngestFrame] = newPage;
      newState.frameAges[youngestFrame] = 0;
    }

    return newState;
  }
}

