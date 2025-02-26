import 'package:flutter/material.dart';
import 'package:geddy_done/presentation/controllers/app_tab_controller.dart';
import 'package:geddy_done/presentation/widgets/pomodoro_timer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
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
              pomodoroDuration: Duration(seconds: 5),
            ),
          ),
          Center(
            child: PomodoroTimer(
              pomodoroDuration: Duration(seconds: 3),
            ),
          ),
        ],
      ),
    );
  }
}
