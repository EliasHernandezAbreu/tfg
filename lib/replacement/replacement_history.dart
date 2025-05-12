class ReplacementHistory {
  List<List<int>> frames = [[]];
  List<int?> importantFrames = [];
  List<bool?> areHits = [];
  final int frameSize;
  int currentSize = 0;

  ReplacementHistory(this.frameSize) {
    frames = [List<int>.filled(frameSize, -1)];
    importantFrames = [null];
    areHits = [null];
    currentSize = 1;
  }

  void addSnapshot(List<int> newFrames, bool? isHit, int? importantFrame) {
    if (newFrames.length != frameSize) throw "Frame sizes dont match";

    areHits.add(isHit);
    importantFrames.add(importantFrame);
    frames.add(newFrames);
    currentSize += 1;
  }
}
