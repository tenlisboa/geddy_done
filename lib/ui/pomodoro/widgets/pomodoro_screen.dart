import 'package:flutter/material.dart';
import 'package:geddy_done/ui/pomodoro/widgets/controllers/app_tab_controller.dart';
import 'package:geddy_done/ui/pomodoro/viewmodels/pomodoro_viewmodel.dart';
import 'package:geddy_done/ui/pomodoro/widgets/pomodoro_timer.dart';

class PomodoroScreen extends StatefulWidget {
  final PomodoroViewmodel viewModel;

  const PomodoroScreen({super.key, required this.viewModel});

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
              viewmodel: widget.viewModel,
            ),
          ),
          Center(
            // child: PomodoroTimer(
            //   pomodoroDuration: Duration(seconds: 3),
            //   onFinishNotification: BreakTimerEndNotification(
            //     notificationService: NotificationService(),
            //   ),
            child: const Placeholder(),
          ),
        ],
      ),
    );
  }
}
