import 'package:flutter/material.dart';
import 'package:tfg/replacement/replacement_history.dart';

class ReplacementHistoryGrid extends StatelessWidget {
  final ReplacementHistory history;

  const ReplacementHistoryGrid({
    super.key,
    required this.history,
  });

  Widget snapshotColumn(BuildContext context, int time) {
    ThemeData theme = Theme.of(context);

    Color subTextColor = theme.hintColor;

    String hitText = "";
    Color hitColor = Colors.white;
    Color cellColor = Colors.white;
    if (history.areHits[time] == true) {
      hitText = "HIT";
      hitColor = Colors.green;
      cellColor = const Color.fromRGBO(200, 255, 200, 0.5);
    }
    if (history.areHits[time] == false) {
      hitText = "FAIL";
      hitColor = Colors.red;
      cellColor = const Color.fromRGBO(255, 200, 200, 0.5);
    }
    List<Widget> columnCells = [];
    for (int i = 0; i < history.frameSize; i++) {
    String cellText = history.frames[time][i].toString();
    if (cellText == "-1") cellText = "";
    columnCells.add(
      Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          color: i == history.importantFrames[time]
            ? cellColor
            : theme.scaffoldBackgroundColor,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cellText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Tooltip(
                  message: "Frame age",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer,
                        size: 12,
                        color: subTextColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        history.frameAges[time][i].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: subTextColor,
                        ),
                      ),
                    ]
                  ),
                ),
                Tooltip(
                  message: "Frame recency",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.punch_clock,
                        size: 12,
                        color: subTextColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        history.frameRecency[time][i].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: subTextColor,
                        ),
                      ),
                    ]
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "$time${hitText == "" ? "" : ": "}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              hitText,
              style: TextStyle(
                color: hitColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        ...columnCells,
      ],
    );
  }

  List<Widget> allSnapshotColumns(BuildContext context) {
    List<Widget> columns = [];
    Widget gap = const SizedBox(width: 12);

    for (int i = 0; i < history.currentSize; i++) {
      columns.add(snapshotColumn(context, i));
      columns.add(gap);
    }
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: allSnapshotColumns(context),
    );
  }
}
