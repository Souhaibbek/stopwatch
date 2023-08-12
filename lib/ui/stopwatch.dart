import 'package:flutter/material.dart';
import 'package:stopwatch/ui/reset_button.dart';
import 'package:stopwatch/ui/start_stop_button.dart';
import 'package:stopwatch/ui/stopwatch_renderer.dart';

import 'stopwatch_ticker_ui.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch>
    with SingleTickerProviderStateMixin {
  final _tickerUiKey = GlobalKey<StopwatchTickerUIState>();
  bool _isRuning = false;

  void _toggleRuning() {
    setState(() {
      _isRuning = !_isRuning;
    });
    _tickerUiKey.currentState?.toggleRunning(_isRuning);
  }

  void _reset() {
    setState(() {
      _isRuning = false;
    });
    _tickerUiKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double radius = constraints.maxWidth / 2;
        return Stack(
          children: [
            StopwatchRenderer(
              radius: radius,
            ),
            StopwatchTickerUI(
              key: _tickerUiKey,
              radius: radius,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                  height: 80,
                  width: 80,
                  child: ResetButton(onPressed: () {
                    _reset();
                  })),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                  height: 80,
                  width: 80,
                  child: StartStopButton(
                      isRunning: _isRuning,
                      onPressed: () {
                        _toggleRuning();
                      })),
            ),
          ],
        );
      },
    );
  }
}
