class CpuProcess {
  int? key;
  int timeToComplete; // Total time it takes to complete | burst time
  int enterTime; // Arrival time
  int priority;

  int remainingTime = 0; // Remaining time to complete | remaining burst time
  int completionTime = -1; // Time at which it was completed
  int turnAroundTime = -1; // Completion Time - Arrival time
  int waitingTime = -1; // turn around time - time to complete

  CpuProcess(this.enterTime, this.timeToComplete, this.priority) {
    remainingTime = timeToComplete;
  }

  @override
  String toString() {
    return "{KEY: $key, TTC: $timeToComplete, ET: $enterTime, RT: $remainingTime, P: $priority}";
  }
}
