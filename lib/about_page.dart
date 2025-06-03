import 'dart:io';

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final void Function() setHomePage;

  const AboutPage({
    super.key,
    required this.setHomePage,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: setHomePage,
                            icon: const Icon(Icons.arrow_back),
                          ),
                          const Text("Back"),
                        ],
                      ),
                    ],
                  ),
        Expanded(child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.file(
                        File("assets/ull.png"),
                        height: 40,
                      ),
                      Row(
                        children: [
                          const Text(
                            "SimOS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 56,
                            ),
                          ),
                          Image.file(
                            File("assets/logo.png"),
                            height: 80,
                            color: theme.iconTheme.color,
                          ),
                        ],
                      )
                    ],
                  ),
                  const Text(
                    "SimOS is a simulator for operating systems algorithms, namely CPU Scheduling algorithms and Page Replacement algorithms.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Developer:"),
                          Text("Elías Hernández Abreu"),
                          Text("alu0101487137@ull.edu.es"),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Tutorized by:"),
                          Text("Vanesa Muñoz Cruz"),
                          Text("Jesús Miguel Torres Jorge"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        )
        )
      ]
    );
  }
}
