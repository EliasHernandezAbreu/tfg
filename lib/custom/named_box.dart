import 'package:flutter/material.dart';

class NamedBox extends StatelessWidget {
  final String name;
  final String label;

  const NamedBox(
    {
      required this.name,
      required this.label,
      super.key,
    }
  );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: theme.cardColor,
        border: const Border(
          bottom: BorderSide(width: 4, color: Colors.blue)
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
          ),
          Expanded(child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        )],
      ),
    );
  }
}
