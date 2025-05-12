class ReplacementContext {
  List<int> frames = [];
  List<int> frameAges = [];
  int failures = 0;
  int hits = 0;

  bool? lastWasHit; 
  int? lastImportant;

  ReplacementContext(int frameAmount) {
    frames = List.filled(frameAmount, -1);
    frameAges = List.filled(frameAmount, 0);
  }

  ReplacementContext.from(ReplacementContext oldState) {
    failures = oldState.failures;
    hits = oldState.hits;

    frames = List.from(oldState.frames);
    frameAges = List.from(oldState.frameAges);
  }

  void tickTime() {
    for (int i = 0; i < frameAges.length; i++) {
      frameAges[i]++;
    }
  }
}
