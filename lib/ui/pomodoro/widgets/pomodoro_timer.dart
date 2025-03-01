import 'package:flutter/material.dart';

import 'package:geddy_done/ui/pomodoro/viewmodels/pomodoro_viewmodel.dart';

class PomodoroTimer extends StatelessWidget {
  final PomodoroViewmodel viewmodel;

  const PomodoroTimer({
    super.key,
    required this.viewmodel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewmodel,
      builder: (context, child) {
        final state = viewmodel.pomodoro;

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
                    onPressed: () async {
                      await viewmodel.pause.execute();
                    },
                    child: const Text("Stop"),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      await viewmodel.start.execute();
                    },
                    child: const Text("Start"),
                  ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await viewmodel.reset.execute();
              },
              child: const Text("Reset"),
            ),
          ],
        );
      },
    );
  }
}
