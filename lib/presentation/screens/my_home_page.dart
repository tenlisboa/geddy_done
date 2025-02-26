import 'package:flutter/material.dart';
import 'package:geddy_done/presentation/widgets/pomodoro_timer.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: PomodoroTimer(),
      ),
    );
  }
}
