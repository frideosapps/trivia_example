import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/appstate.dart';
import '../models/models.dart';
import '../models/trivia_stats.dart';
import '../widgets/summaryanswer_widget.dart';
import '../styles.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({this.stats});

  final TriviaStats stats;

  List<Widget> _buildQuestions() {
    var index = 0;

    final widgets = List<Widget>()
      ..add(
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: Text(
            'Final score: ${stats.score}',
            style: summaryScoreStyle,
          ),
        ),
      );

    if (stats.corrects.isNotEmpty) {
      widgets
        ..add(
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 32,
            color: Colors.indigo[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'CORRECTS: ${stats.corrects.length}',
                  style: correctsHeaderStyle,
                ),
              ],
            ),
          ),
        )
        ..addAll(
          stats.corrects.map((question) {
            index++;
            return SummaryAnswers(
              index: index,
              question: question,
            );
          }),
        );
    }

    if (stats.wrongs.isNotEmpty) {
      widgets
        ..add(
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 32,
            color: Colors.indigo[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'WRONGS: ${stats.wrongs.length}',
                  style: wrongsHeaderStyle,
                ),
              ],
            ),
          ),
        )
        ..addAll(
          stats.wrongs.map((question) {
            index++;
            return SummaryAnswers(
              index: index,
              question: question,
            );
          }),
        );
    }

    if (stats.noAnswered.isNotEmpty) {
      widgets
        ..add(
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 32,
            color: Colors.indigo[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'NOT GIVEN: ${stats.noAnswered.length}',
                  style: notAnsweredHeaderStyle,
                ),
              ],
            ),
          ),
        )
        ..addAll(
          stats.noAnswered.map((question) {
            index++;
            return SummaryAnswers(
              index: index,
              question: question,
            );
          }),
        );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    final List<Widget> widgets = _buildQuestions()
      ..add(Container(
        height: 24,
      ))
      ..add(Container(
        width: 90,
        child: RaisedButton(
          child: const Text('Home'),
          onPressed: () => appState.tabController.value = AppTab.main,
        ),
      ));

    return FadeInWidget(
      duration: 750,
      child: Container(
        child: ListView(
          shrinkWrap: true,
          children: widgets,
        ),
      ),
    );
  }
}
