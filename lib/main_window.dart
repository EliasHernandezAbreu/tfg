import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg/about_page.dart';
import 'package:tfg/app_page.dart';
import 'package:tfg/global_state.dart';
import 'package:tfg/home_page.dart';
import 'package:tfg/planning/planning_page.dart';
import 'package:tfg/replacement/replacement_page.dart';

class MainWindow extends StatefulWidget {
  final void Function(bool value) setDarkMode;

  const MainWindow({
    super.key,
    required this.setDarkMode,
  });

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  AppPage _appPage = AppPage.home;

  void setAppPage(AppPage newPage, BuildContext context) {
    setState(() {
      _appPage = newPage;
      Navigator.maybePop(context);
    });
  }

  void exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  Widget drawerEntry(IconData icon, String label, void Function() callback) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 30),
          Text(label),
        ],
      ),
      onTap: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {setAppPage(AppPage.home, context);},
            icon: const Icon(Icons.home),
          ),
          Switch(
            value: GlobalState.darkMode,
            onChanged: widget.setDarkMode,
            thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const Icon(Icons.dark_mode);
              }
              return const Icon(Icons.light_mode); // All other states will use the default thumbIcon.
            }),
          ),
        ],
        title: Row(
          children: [
            const Text("SimOS"),
            const SizedBox(width: 20),
            Image.file(
              File("assets/logo.png"),
              height: 40,
              color: theme.iconTheme.color,
            )
          ],
        )
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  const Text('SimOS'),
                  Image.file(
                    File("assets/logo.png"),
                    width: 100,
                    color: theme.iconTheme.color,
                  )
                ],
              )
            ),
            drawerEntry(Icons.home, "Home", () {setAppPage(AppPage.home, context);}),
            drawerEntry(Icons.pix, "Process planning", () {setAppPage(AppPage.planning, context);}),
            drawerEntry(Icons.content_copy, "Page replacement", () {setAppPage(AppPage.replacement, context);}),
            drawerEntry(Icons.info, "About", () {setAppPage(AppPage.about, context);}),
          ],
        ),
      ),
      extendBody: true,
      body: switch (_appPage) {
        AppPage.home => HomePage(
          setAboutPage: () {setAppPage(AppPage.about, context);},
          setReplacementPage: () {setAppPage(AppPage.replacement, context);},
          setPlanningPage: () {setAppPage(AppPage.planning, context);},
          exitFunction: exitApp,
        ),
        AppPage.planning => const PlanningPage(),
        AppPage.replacement => const ReplacementPage(),
        AppPage.about => const AboutPage(),
      },
    );
  }
}
