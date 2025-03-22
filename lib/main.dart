import 'package:flutter/material.dart';
import 'package:tfg/main_window.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'SimOS',
            theme: ThemeData(
                primaryColor: Colors.blue,
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white
                ),
                useMaterial3: true,
            ),
        home: const MainWindow(),
        );
    }
}
