import 'package:tfg/process.dart';

class PlanningState {
  int currentTime = 0;
  CpuProcess? currentProcess;
  Set<CpuProcess> pendingEnter = {};
  Set<CpuProcess> ready = {};
  Set<CpuProcess> waitingIO = {};
  Set<CpuProcess> completed = {};

  PlanningState(this.pendingEnter) {
    for (CpuProcess process in pendingEnter) {
      if (process.enterTime > currentTime) continue;
      pendingEnter.remove(process);
      ready.add(process);
    }
  }

  PlanningState.from(PlanningState oldState) {
    currentTime = oldState.currentTime;
    currentProcess = oldState.currentProcess;

    pendingEnter = Set.from(oldState.pendingEnter);
    ready = Set.from(oldState.ready);
    waitingIO = Set.from(oldState.waitingIO);
    completed = Set.from(oldState.completed);
  }

  void tickTime() {
    currentTime += 1;
    if (currentProcess != null) {
      currentProcess?.remainingTime -= 1;
      if (currentProcess!.remainingTime <= 0) {
        completed.add(currentProcess!);
        currentProcess = null;
      }
    }
    for (CpuProcess process in pendingEnter) {
      if (process.enterTime > currentTime) continue;
      pendingEnter.remove(process);
      ready.add(process);
    }
  }

  bool moveToCpu(CpuProcess process) {
    if (!ready.contains(process)) return false;
    ready.remove(process);
    currentProcess = process;
    return true;
  }
}
