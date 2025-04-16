import 'package:flutter/material.dart';

class LabeledColumn extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const LabeledColumn({
    super.key,
    required this.label,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 40,
          color: Colors.blue,
          height: 5,
        ),
        const SizedBox(height: 8),
        ...children.map((Widget w) {
          return Container(
            margin: const EdgeInsets.all(2),
            child: w,
          );
        })
      ],
    ));
  }
}
