class ReplacementContext {
  List<int> frames = [];
  List<int> frameAges = [];
  List<int> useRecency = [];
  int failures = 0;
  int hits = 0;

  bool? lastWasHit; 
  int? lastImportant;

  ReplacementContext(int frameAmount) {
    frames = List.filled(frameAmount, -1);
    frameAges = List.filled(frameAmount, 0);
    useRecency = List.filled(frameAmount, 0);
  }

  ReplacementContext.from(ReplacementContext oldState) {
    failures = oldState.failures;
    hits = oldState.hits;

    frames = List.from(oldState.frames);
    frameAges = List.from(oldState.frameAges);
    useRecency = List.from(oldState.useRecency);
  }

  void tickTime() {
    for (int i = 0; i < frameAges.length; i++) {
      frameAges[i]++;
      useRecency[i]++;
    }
  }

  // Returns the index of the page or -1 if not found
  int checkPage(int page) {
    for (int i = 0; i < frames.length; i++) {
      if (frames[i] != page) continue;
      useRecency[i] = 0;
      lastImportant = i;
      lastWasHit = true;
      hits += 1;
      return i;
    }
    lastWasHit = false;
    failures += 1;
    return -1;
  }

  void replacePage(int index, int page) {
    lastImportant = index;
    frames[index] = page;
    useRecency[index] = 0;
    frameAges[index] = 0;
  }
}
