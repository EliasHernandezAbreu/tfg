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
    return Container(
      width: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        border: Border(
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
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        )],
      ),
    );
  }
}
