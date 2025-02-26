import 'package:flutter/material.dart';
import 'package:geddy_done/data/repositories/timer_repository.dart';

class PomodoroTimer extends StatelessWidget {
  PomodoroTimer({super.key});

  final TimerRepository timerRepository =
      TimerRepository(pomodoroDuration: const Duration(seconds: 5));

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: timerRepository,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                timerRepository.pomodoroDuration.toString().split('.').first,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              timerRepository.isRunning
                  ? ElevatedButton(
                      onPressed: () {
                        timerRepository.stopTimer();
                      },
                      child: Text("Stop"),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        timerRepository.startTimer();
                      },
                      child: Text("Start"),
                    )
            ],
          );
        });
  }
}
