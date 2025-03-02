import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      var pomodoroDuration = showDurationPicker(
                          context: context, initialTime: Duration(minutes: 25));
                    },
                    label: const Text('Set Pomodoro Duration'),
                    icon: const Icon(Icons.timer),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      var breakDuration = showDurationPicker(
                          context: context, initialTime: Duration(minutes: 5));
                    },
                    label: const Text('Set Break Duration'),
                    icon: const Icon(Icons.stop_circle_sharp),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
