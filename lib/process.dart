class CpuProcess {
  final int timeToComplete;
  final int enterTime;

  int remainingTime = 0;

  CpuProcess(this.enterTime, this.timeToComplete) {
    remainingTime = timeToComplete;
  }
}
