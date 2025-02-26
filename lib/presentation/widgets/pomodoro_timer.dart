import 'package:flutter/material.dart';
import 'package:geddy_done/data/repositories/timer_repository.dart';
import 'package:geddy_done/data/services/timer_service.dart';
import 'package:geddy_done/contracts/timer_notification.dart';

class PomodoroTimer extends StatefulWidget {
  final Duration pomodoroDuration;

  final TimerNotification onFinishNotification;

  const PomodoroTimer(
      {super.key,
      required this.pomodoroDuration,
      required this.onFinishNotification});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  late TimerRepository timerRepository;
  late TimerService timerService;

  @override
  void initState() {
    super.initState();
    timerRepository = TimerRepository(initialDuration: widget.pomodoroDuration);
    timerService = TimerService(
      repository: timerRepository,
      notification: widget.onFinishNotification,
    );
  }

  @override
  void dispose() {
    timerRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: timerRepository,
      builder: (context, child) {
        final state = timerRepository.getTimerState();

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.currentDuration.toString().split('.').first,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            state.isRunning
                ? ElevatedButton(
                    onPressed: () {
                      timerService.stopTimer();
                    },
                    child: const Text("Stop"),
                  )
                : ElevatedButton(
                    onPressed: () {
                      timerService.startTimer();
                    },
                    child: const Text("Start"),
                  ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                timerService.resetTimer();
              },
              child: const Text("Reset"),
            ),
          ],
        );
      },
    );
  }
}
