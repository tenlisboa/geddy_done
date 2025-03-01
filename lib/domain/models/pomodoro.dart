class Pomodoro {
  final Duration currentDuration;
  final Duration initialDuration;
  final bool isRunning;

  Pomodoro({
    required this.currentDuration,
    Duration? initialDuration,
    bool? isRunning,
  })  : initialDuration = initialDuration ?? currentDuration,
        isRunning = isRunning ?? false;

  Pomodoro copyWith({
    Duration? currentDuration,
    Duration? initialDuration,
    bool? isRunning,
  }) {
    return Pomodoro(
      currentDuration: currentDuration ?? this.currentDuration,
      initialDuration: initialDuration ?? this.initialDuration,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}
