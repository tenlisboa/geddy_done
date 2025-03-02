import 'package:flutter/material.dart';

class AppTabController extends TabController {
  static const List<Tab> tabs = [
    Tab(icon: Icon(Icons.timer), text: 'Pomodoro'),
    Tab(icon: Icon(Icons.stop_circle_rounded), text: 'Break'),
  ];

  AppTabController({required super.vsync}) : super(length: tabs.length);
}
