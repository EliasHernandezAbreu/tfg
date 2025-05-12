import 'package:flutter/material.dart';
import 'package:tfg/replacement/replacement_history.dart';

class ReplacementHistoryGrid extends StatelessWidget {
  final ReplacementHistory history;

  const ReplacementHistoryGrid({
    super.key,
    required this.history,
  });

  Widget snapshotColumn(int time) {
    String hitText = "";
    Color hitColor = Colors.white;
    Color cellColor = Colors.white;
    if (history.areHits[time] == true) {
      hitText = "HIT";
      hitColor = Colors.green;
      cellColor = const Color.fromRGBO(200, 255, 200, 1);
    }
    if (history.areHits[time] == false) {
      hitText = "FAIL";
      hitColor = Colors.red;
      cellColor = const Color.fromRGBO(255, 200, 200, 1);
    }
    List<Widget> columnCells = [];
    for (int i = 0; i < history.frameSize; i++) {
    String cellText = history.frames[time][i].toString();
    if (cellText == "-1") cellText = "";
    columnCells.add(
      Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: i == history.importantFrames[time] ? cellColor : Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Text(
          cellText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
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
                color: Colors.black,
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

  List<Widget> allSnapshotColumns() {
    List<Widget> columns = [];
    Widget gap = const SizedBox(width: 12);

    for (int i = 0; i < history.currentSize; i++) {
      columns.add(snapshotColumn(i));
      columns.add(gap);
    }
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: allSnapshotColumns(),
    );
  }
}
