class TimerState {
  final bool isRunning;
  final Duration currentDuration;
  final Duration originalDuration;
  final int pomodoros;

  TimerState({
    this.isRunning = false,
    required this.currentDuration,
    required this.originalDuration,
    this.pomodoros = 4,
  });

  TimerState copyWith({
    bool? isRunning,
    Duration? currentDuration,
    Duration? originalDuration,
    int? pomodoros,
  }) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      currentDuration: currentDuration ?? this.currentDuration,
      originalDuration: originalDuration ?? this.originalDuration,
      pomodoros: pomodoros ?? this.pomodoros,
    );
  }
}
