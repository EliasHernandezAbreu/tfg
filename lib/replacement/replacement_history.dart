import 'package:tfg/replacement/replacement_context.dart';

class ReplacementHistory {
  List<List<int>> frames = [[]];
  List<List<int>> frameAges = [[]];
  List<List<int>> frameRecency = [[]];
  List<int?> importantFrames = [];
  List<bool?> areHits = [];
  final int frameSize;
  int currentSize = 0;

  ReplacementHistory(this.frameSize) {
    frames = [List<int>.filled(frameSize, -1)];
    frameAges = [List<int>.filled(frameSize, 0)];
    frameRecency = [List<int>.filled(frameSize, 0)];
    importantFrames = [null];
    areHits = [null];
    currentSize = 1;
  }

  void addSnapshot(ReplacementContext context) {
    if (context.frames.length != frameSize) throw "Frame sizes dont match";

    areHits.add(context.lastWasHit);
    importantFrames.add(context.lastImportant);
    frames.add(context.frames);
    frameAges.add(context.frameAges);
    frameRecency.add(context.useRecency);
    currentSize += 1;
  }
}
