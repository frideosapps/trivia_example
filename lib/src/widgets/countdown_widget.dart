import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/models.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget(
      {@required this.width, Key key, this.duration, this.triviaState})
      : assert(width != null),
        super(key: key);

  final double width;
  final int duration; // Milliseconds
  final TriviaState triviaState;

  @override
  CountdownWidgetState createState() {
    return CountdownWidgetState();
  }
}

class CountdownWidgetState extends State<CountdownWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Color color;
  final double countdownBarHeight = 24.0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    animation = Tween<double>(begin: widget.width, end: 0).animate(controller)
      ..addListener(() {
        setState(() {
          // Animate the countdown bar from green to red
          final value = (animation.value ~/ 2).toInt();
          color = Color.fromRGBO(255 - value, value > 255 ? 255 : value, 0, 1);
        });

        // Stop the animation if an anwser is chosen
        if (widget.triviaState.isAnswerChosen) {
          controller.stop();
        }
      });

    color = Colors.green;
  }

  @override
  void didUpdateWidget(CountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    color = Colors.green;

    // If the user click on an anwser the countdown animation
    // will stop.
    if (widget.triviaState.isAnswerChosen) {
      controller.stop();
    }
    // Otherwise, when a new question appears on the screen and
    // the widget rebuilds, then reset and play the countdown bar
    // animation.
    else {
      controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: countdownBarHeight,
          width: animation.value,
          child: BlurWidget(
            sigmaX: 12.0,
            sigmaY: 13.0,
            child: Container(
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
