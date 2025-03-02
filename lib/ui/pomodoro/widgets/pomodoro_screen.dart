import 'package:flutter/material.dart';
import 'package:geddy_done/ui/pomodoro/widgets/controllers/app_tab_controller.dart';
import 'package:geddy_done/ui/pomodoro/viewmodels/timer_viewmodel.dart';
import 'package:geddy_done/ui/pomodoro/widgets/pomodoro_timer.dart';
import 'package:geddy_done/ui/settings/widgets/settings_screen.dart';

class PomodoroScreen extends StatefulWidget {
  final TimerViewmodel pomodoroViewModel;
  final TimerViewmodel timerViewModel;

  const PomodoroScreen({
    super.key,
    required this.pomodoroViewModel,
    required this.timerViewModel,
  });

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen>
    with SingleTickerProviderStateMixin {
  late AppTabController _tabController;

  @override
  void initState() {
    _tabController = AppTabController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('GeddyDone'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: AppTabController.tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: PomodoroTimer(
              viewmodel: widget.pomodoroViewModel,
            ),
          ),
          Center(
            child: PomodoroTimer(
              viewmodel: widget.timerViewModel,
            ),
          ),
        ],
      ),
    );
  }
}
