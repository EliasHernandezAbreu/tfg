import 'package:flutter/material.dart';
import 'package:tfg/global_state.dart';
import 'package:tfg/main_window.dart';

void main() {
  runApp(const SimOS());
}

class SimOS extends StatefulWidget {
  const SimOS({super.key});

  @override
  State<StatefulWidget> createState() => _SimOS();
}

class _SimOS extends State<SimOS> {
  void setDarkMode(bool value) {
    setState(() {
      GlobalState.darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimOS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        )
      ),
      themeMode: GlobalState.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: MainWindow(
        setDarkMode: setDarkMode
      ),
    );
  }
}
