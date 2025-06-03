import 'package:flutter/material.dart';
import 'package:tfg/replacement/replacement_page_interactive.dart';

class ReplacementPage extends StatefulWidget {
  final void Function() setHomePage;

  const ReplacementPage({
    super.key,
    required this.setHomePage,
  });

  @override
  State<StatefulWidget> createState() {
    return _ReplacementPageState();
  }
}

class _ReplacementPageState extends State<ReplacementPage> {
  int currentPage = 0;

  Widget getCurrentPage() {
    switch (currentPage) {
      case 0: return ReplacementPageInteractive(
        backFunction: widget.setHomePage,
      );
      default: return const Text("Woops");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: getCurrentPage(),
    );
  }
}
