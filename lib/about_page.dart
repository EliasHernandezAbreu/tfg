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
    bool vertical = MediaQuery.sizeOf(context).width < 700;

    return Column(
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
        Expanded(child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: vertical ? 5 : 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flex(
                    direction: vertical ? Axis.vertical : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/ull.png",
                        height: 40,
                      ),
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
                  Flex(
                    direction: vertical ? Axis.vertical : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Column(
                        children: [
                          Text("Developer:"),
                          Text("Elías Hernández Abreu"),
                          Text("alu0101487137@ull.edu.es"),
                        ],
                      ),
                      SizedBox(height: 20),
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
