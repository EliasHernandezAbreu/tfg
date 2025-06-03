import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final void Function() setReplacementPage;
  final void Function() setPlanningPage;
  final void Function() setAboutPage;
  final void Function() exitFunction;

  const HomePage({
    super.key,
    required this.setAboutPage,
    required this.exitFunction,
    required this.setPlanningPage,
    required this.setReplacementPage,
  });

  Widget menuButton(IconData icon, String label, void Function() callback) {
    return IconButton(
      onPressed: callback,
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 30,),
          Text(label)
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "SimOS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 56,
              ),
            ),
            Image.asset(
              "assets/logo.png",
              height: 80,
              color: theme.iconTheme.color,
            ),
          ],
        ),
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                menuButton(Icons.pix, "Process planning", setPlanningPage),
                menuButton(Icons.content_copy, "Page replacement", setReplacementPage),
                menuButton(Icons.info, "About", setAboutPage),
                menuButton(Icons.exit_to_app, "Exit", exitFunction),
              ],
            )
          ]
        ),
      ],
    );
  }
}
