class CpuProcess {
  int timeToComplete;
  int enterTime;

  int remainingTime = 0;

  CpuProcess(this.enterTime, this.timeToComplete) {
    remainingTime = timeToComplete;
  }
}
