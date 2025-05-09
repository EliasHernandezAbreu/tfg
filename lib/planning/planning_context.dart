import 'package:tfg/planning/cpu_process.dart';

class PlanningContext {
  int currentTime = -1;
  CpuProcess? currentProcess;
  List<CpuProcess> pendingEnter = [];
  List<CpuProcess> ready = [];
  List<CpuProcess> waitingIO = [];
  List<CpuProcess> completed = [];

  PlanningContext(List<CpuProcess> processes) {
    for (int index = 0; index < processes.length; index++) {
      CpuProcess process = processes[index];
      process.remainingTime = process.timeToComplete;
      process.key = index;
      if (process.enterTime > currentTime) {
        pendingEnter.add(process);
      } else {
        ready.add(process);
      }
    }
  }

  PlanningContext.from(PlanningContext oldState) {
    currentTime = oldState.currentTime;
    currentProcess = oldState.currentProcess;

    pendingEnter = List.from(oldState.pendingEnter);
    ready = List.from(oldState.ready);
    waitingIO = List.from(oldState.waitingIO);
    completed = List.from(oldState.completed);
  }

  // Updates time and adds ready processes to the list
  void tickTime() {
    currentTime += 1;
    List<CpuProcess> nextPendingEnter = List<CpuProcess>.from(pendingEnter);
    for (CpuProcess process in pendingEnter) {
      if (process.enterTime > currentTime) continue;
      nextPendingEnter.remove(process);
      ready.add(process);
    }
    pendingEnter = nextPendingEnter;
  }

  // Handles reducing the remaining time of the process in the CPU
  void burstCpu() {
    if (currentProcess == null) return;
    currentProcess?.remainingTime -= 1;
    if (currentProcess!.remainingTime <= 0) {
      completed.add(currentProcess!);
      currentProcess = null;
    }
  }

  bool hasCurrentProcess() {
    return currentProcess != null;
  }

  bool moveToCpu(CpuProcess process) {
    if (!ready.contains(process)) return false;
    ready.remove(process);
    if (currentProcess != null) {
      ready.add(currentProcess!);
    }
    currentProcess = process;
    return true;
  }
}
