import 'package:flutter/material.dart';
import 'package:tfg/custom/number_input.dart';
import 'package:tfg/global_state.dart';
import 'package:tfg/replacement/replacement_context.dart';
import 'package:tfg/replacement/replacement_history.dart';
import 'package:tfg/replacement/replacement_history_grid.dart';

class ReplacementPageInteractive extends StatefulWidget {
  final void Function() backFunction;

  const ReplacementPageInteractive({
    super.key,
    required this.backFunction,
  });

  @override
  State<StatefulWidget> createState() => _ReplacementPageInteractive();
}

class _ReplacementPageInteractive extends State<ReplacementPageInteractive> {
  ScrollController controller = ScrollController(
  );
  int newPage = 0;
  ReplacementHistory _history = ReplacementHistory(GlobalState.replacementFrameAmount);
  ReplacementContext _context = ReplacementContext(GlobalState.replacementFrameAmount);

  void handleDropdownSelected(int? newAlgoIndex) {
    setState(() {
      GlobalState.currentReplacementAlgorithm = newAlgoIndex!;
    });
  }

  void handleNumberInputChange(int value) {
    newPage = value;
  }

  void handleButtonClick() {
    sendNewPage(newPage);
  }

  void setFrameAmount(int value) {
    GlobalState.replacementFrameAmount = value;
    restartSimulation();
  }

  void sendNewPage(int page) {
    setState(() {
      var algo = GlobalState.replacementAlgorithms[GlobalState.currentReplacementAlgorithm].$2;
      var newContext = algo.nextState(_context, page);
      _history.addSnapshot(newContext);
      _context = newContext;

    });

    setState(() {
      controller.animateTo(
        controller.position.maxScrollExtent + 200,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  void restartSimulation() {
    setState(() {
      _history = ReplacementHistory(GlobalState.replacementFrameAmount);
      _context = ReplacementContext(GlobalState.replacementFrameAmount);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool smallScreen = MediaQuery.sizeOf(context).width < 500;

    List<Widget> quickPages = [];
    for (int i = 0; i <= 99; i++) {
      quickPages.add(
        GestureDetector(
          onTap: () {sendNewPage(i);},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                width: 2,
                color: Colors.black54,
              )
            ),
            child: Center(
              child: Text(
                i.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            )
          )
        )
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: widget.backFunction,
                  icon: const Icon(Icons.arrow_back),
                ),
                const Text("Back"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Restart"),
                IconButton(
                  onPressed: restartSimulation,
                  icon: const Icon(Icons.restore),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 4, color: Colors.black38),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "HITS: ${_context.hits}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 50),
                    Text(
                      "FAILURES: ${_context.failures}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Scrollbar(
                    controller: controller,
                    child: SingleChildScrollView(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Row(
                          children: [
                            ReplacementHistoryGrid(
                              onCellClick: sendNewPage,
                              history: _history
                            ),
                          ],
                        ),
                      )
                    )
                  )
                ),
              ],
            ),
          )
        ),
        Flex(
          direction: smallScreen ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Algorithm:"),
                const SizedBox(width: 20),
                DropdownMenu(
                  onSelected: handleDropdownSelected,
                  initialSelection: GlobalState.currentReplacementAlgorithm,
                  dropdownMenuEntries: [
                    ...GlobalState.replacementAlgorithms.indexed.map((entry) {
                      int index = entry.$1;
                      var algoDef = entry.$2;
                      return DropdownMenuEntry(value: index, label: algoDef.$1);
                    })
                  ]
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Frame amount:"),
                const SizedBox(width: 20),
                SizedBox(
                  width: 100,
                  child: NumberInput(
                    initialValue: GlobalState.replacementFrameAmount,
                    minValue: 1,
                    maxValue: 50,
                    onChanged: setFrameAmount,
                    onSubmit: setFrameAmount,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
              crossAxisCount: (MediaQuery.sizeOf(context).width / 100).floor(),
              children: quickPages
            ),
        ),
      ],
    );
  }
}
