class CpuProcess {
  int? key;
  int timeToComplete;
  int enterTime;
  int priority;

  int remainingTime = 0;

  CpuProcess(this.enterTime, this.timeToComplete, this.priority) {
    remainingTime = timeToComplete;
  }

  @override
  String toString() {
    return "{KEY: $key, TTC: $timeToComplete, ET: $enterTime, RT: $remainingTime, P: $priority}";
  }
}
