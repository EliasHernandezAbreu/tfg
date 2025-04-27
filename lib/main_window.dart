import 'package:flutter/material.dart';
import 'package:tfg/app_page.dart';
import 'package:tfg/home_page.dart';
import 'package:tfg/planning/planning_page.dart';
import 'package:tfg/replacement/replacement_page.dart';

class MainWindow extends StatefulWidget {
  const MainWindow({super.key});

  @override
  State<MainWindow> createState() {
    return _MainWindowState();
  }
}

class _MainWindowState extends State<MainWindow> {
  AppPage _appPage = AppPage.home;

  void setAppPage(AppPage newPage, BuildContext context) {
    setState(() {
      _appPage = newPage;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimOS'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('SimOS')),
            ListTile(
              title: const Text('Home'),
              onTap: () { setAppPage(AppPage.home, context); },
            ),
            ListTile(
              title: const Text('Process planning'),
              onTap: () { setAppPage(AppPage.planning, context); },
            ),
            ListTile(
              title: const Text('Page replacement'),
              onTap: () { setAppPage(AppPage.replacement, context); },
            )
          ],
        ),
      ),
      extendBody: true,
      body: switch (_appPage) {
        AppPage.home => const HomePage(),
        AppPage.planning => const PlanningPage(),
        AppPage.replacement => const ReplacementPage(),
      },
    );
  }
}
