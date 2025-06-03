import 'package:tfg/planning/cpu_process.dart';

class PlanningContext {
  int currentTime = -1;
  int timeSinceLastSwap = 0;
  CpuProcess? currentProcess;
  bool finished = false;
  List<CpuProcess> pendingEnter = [];
  List<CpuProcess> ready = [];
  List<CpuProcess> waitingIO = [];
  List<CpuProcess> completed = [];

  double averageWaitingTime = 0;
  double averageTurnAroundTime = 0;

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
    timeSinceLastSwap = oldState.timeSinceLastSwap;
    finished = oldState.finished;
    averageWaitingTime = oldState.averageWaitingTime;
    averageTurnAroundTime = oldState.averageTurnAroundTime;

    pendingEnter = List.from(oldState.pendingEnter);
    ready = List.from(oldState.ready);
    waitingIO = List.from(oldState.waitingIO);
    completed = List.from(oldState.completed);
  }

  // Updates time and adds ready processes to the list
  void tickTime() {
    currentTime += 1;
    timeSinceLastSwap += 1;
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
      currentProcess!.completionTime = currentTime;
      currentProcess!.turnAroundTime = currentTime - currentProcess!.enterTime;
      currentProcess!.waitingTime = currentProcess!.turnAroundTime - currentProcess!.timeToComplete;
      completed.add(currentProcess!);
      currentProcess = null;
    }
    if (pendingEnter.isEmpty && ready.isEmpty && currentProcess == null) {
      finished = true;
      for (CpuProcess process in completed) {
        averageWaitingTime += process.waitingTime;
        averageTurnAroundTime += process.turnAroundTime;
      }
      averageWaitingTime /= completed.length;
      averageTurnAroundTime /= completed.length;
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
    timeSinceLastSwap = 0;
    return true;
  }
}
