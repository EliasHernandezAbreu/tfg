import 'package:flutter/material.dart';

void debugButton() {
    print("hi");
}

class Menu extends StatelessWidget {
    const Menu({super.key});

    @override
    Widget build(BuildContext context) {
        return const Scaffold(
            body: Center(
                child: Column(
                    children: [
                        TextButton(
                            onPressed: debugButton,
                            child: Text("Hello"),
                        )
                    ],
                )
            )
        );
    }
}

