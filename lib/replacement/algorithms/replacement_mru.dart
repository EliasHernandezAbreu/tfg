import 'package:tfg/replacement/replacement_algorithm.dart';
import 'package:tfg/replacement/replacement_context.dart';

class ReplacementMru extends ReplacementAlgorithm {
  @override
  ReplacementContext nextState(ReplacementContext oldState, int newPage) {
    ReplacementContext newState = ReplacementContext.from(oldState);
    newState.tickTime();

    int index = newState.checkPage(newPage);
    if (index < 0) {
      int youngestFrame = 0;
      int youngestFrameAge = 0;
      for (int i = 0; i < newState.useRecency.length; i++) {
        if (newState.frames[youngestFrame] == -1) break;
        if (newState.frames[i] == -1) {
          youngestFrame = i;
          break;
        }
        if (newState.useRecency[i] < youngestFrameAge) {
          youngestFrame = i;
          youngestFrameAge = newState.useRecency[i];
        }
      }
      newState.replacePage(youngestFrame, newPage);
    }

    return newState;
  }
}

