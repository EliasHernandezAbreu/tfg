import 'package:flutter/material.dart';
import 'package:tfg/planning/cpu_process.dart';

enum CpuProcessViewMainElement {
  enterTime,
  remainingTime,
  completionTime,
}

class CpuProcessView extends StatefulWidget {
  final CpuProcess process;
  final CpuProcessViewMainElement mainElement;

  const CpuProcessView({
    super.key,
    required this.process,
    required this.mainElement,
  });

  @override
  State<StatefulWidget> createState() => _CpuProcessView();
}

class _CpuProcessView extends State<CpuProcessView> {
  bool visibleDetails = false;

  void onCellClick() {
    setState(() {
      visibleDetails = !visibleDetails;
    });
  }

  Widget infoRow(IconData icon, String value, String tooltip, bool main) {
    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisAlignment: main ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: main ? 24 : 16,
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: main ? 24 : 14,
            )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Widget mainInfoRow = const Column();
    if (widget.mainElement == CpuProcessViewMainElement.enterTime) {
      mainInfoRow = infoRow(
        Icons.punch_clock,
        widget.process.enterTime.toString(),
        "Enter time",
        true
      );
    } else if (widget.mainElement == CpuProcessViewMainElement.remainingTime) {
      mainInfoRow = infoRow(
        Icons.timer,
        widget.process.remainingTime.toString(),
        "Remaining time",
        true
      );
    } else if (widget.mainElement == CpuProcessViewMainElement.completionTime) {
      mainInfoRow = infoRow(
        Icons.star,
        widget.process.completionTime.toString(),
        "Completion time",
        true
      );
    }

    return GestureDetector(
      onTap: onCellClick,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: theme.cardColor,
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.process.key.toString(),
                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: mainInfoRow,
                )
              ],
            ),
            Visibility(
              visible: visibleDetails,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.mainElement != CpuProcessViewMainElement.enterTime) infoRow(
                    Icons.punch_clock,
                    widget.process.enterTime.toString(),
                    "Enter time",
                    false
                  ),
                  if (widget.mainElement != CpuProcessViewMainElement.remainingTime) infoRow(
                    Icons.timer,
                    widget.process.timeToComplete.toString(),
                    "Time to complete",
                    false
                  ),
                  if (widget.mainElement == CpuProcessViewMainElement.completionTime) infoRow(
                    Icons.lock_clock,
                    widget.process.turnAroundTime.toString(),
                    "Turn around time",
                    false
                  ),
                  if (widget.mainElement == CpuProcessViewMainElement.completionTime) infoRow(
                    Icons.signal_wifi_bad,
                    widget.process.waitingTime.toString(),
                    "Waiting time",
                    false
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
