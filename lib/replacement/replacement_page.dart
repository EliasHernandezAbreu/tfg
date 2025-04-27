import 'package:flutter/material.dart';

class ReplacementPage extends StatefulWidget {
  const ReplacementPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ReplacementPageState();
  }
}

class _ReplacementPageState extends State<ReplacementPage> {
  int pageFrames = 1;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text("something something")
        ],
      ),
    );
  }
}
