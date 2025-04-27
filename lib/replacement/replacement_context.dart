class ReplacementContext {
  List<int> frames = [];
  int failures = 0;
  int hits = 0;

  ReplacementContext(int frameAmount) {
    frames = List.filled(frameAmount, -1);
  }

  ReplacementContext.from(ReplacementContext oldState) {
    failures = oldState.failures;
    hits = oldState.hits;

    frames = List.from(oldState.frames);
  }
}
