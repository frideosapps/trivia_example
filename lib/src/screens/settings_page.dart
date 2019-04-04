import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/appstate.dart';
import '../models/models.dart';
import '../models/question.dart';
import '../models/theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final countdownController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    countdownController.text =
        (appState.triviaBloc.countdown / 1000).toStringAsFixed(0);

    amountController.text = (appState.questionsAmount.value);

    List<Widget> _buildThemesList() {
      return appState.themes.map((MyTheme appTheme) {
        return DropdownMenuItem<MyTheme>(
          value: appTheme,
          child: Text(appTheme.name, style: const TextStyle(fontSize: 14.0)),
        );
      }).toList();
    }

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Choose a theme:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                ValueBuilder<MyTheme>(
                    streamed: appState.currentTheme,
                    builder: (context, snapshot) {
                      return DropdownButton<MyTheme>(
                        hint: const Text('Status'),
                        value: snapshot.data,
                        items: _buildThemesList(),
                        onChanged: appState.setTheme,
                      );
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Quiz database:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                ValueBuilder<ApiType>(
                    streamed: appState.apiType,
                    builder: (context, snapshot) {
                      return DropdownButton<ApiType>(
                          value: snapshot.data,
                          onChanged: appState.setApiType,
                          items: [
                            const DropdownMenuItem<ApiType>(
                              value: ApiType.mock,
                              child: Text('Demo'),
                            ),
                            const DropdownMenuItem<ApiType>(
                              value: ApiType.remote,
                              child: Text('opentdb.com'),
                            ),
                          ]);
                    }),
              ],
            ),
            ValueBuilder<ApiType>(
                streamed: appState.apiType,
                builder: (context, snapshot) {
                  return snapshot.data == ApiType.mock
                      ? Container()
                      : Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'N. of questions:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  child: StreamBuilder<String>(
                                      stream: appState
                                          .questionsAmount.outTransformed,
                                      builder: (context, snapshot) {
                                        return Expanded(
                                          child: TextField(
                                            controller: amountController,
                                            onChanged: appState
                                                .questionsAmount.inStream,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'Enter a value between 2 and 15.',
                                              errorText: snapshot.error,
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Difficulty:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                ValueBuilder<QuestionDifficulty>(
                                    streamed: appState.questionsDifficulty,
                                    builder: (context, snapshot) {
                                      return DropdownButton<QuestionDifficulty>(
                                          value: snapshot.data,
                                          onChanged: appState.setDifficulty,
                                          items: [
                                            const DropdownMenuItem<
                                                QuestionDifficulty>(
                                              value: QuestionDifficulty.easy,
                                              child: Text('Easy'),
                                            ),
                                            const DropdownMenuItem<
                                                QuestionDifficulty>(
                                              value: QuestionDifficulty.medium,
                                              child: Text('Medium'),
                                            ),
                                            const DropdownMenuItem<
                                                QuestionDifficulty>(
                                              value: QuestionDifficulty.hard,
                                              child: Text('Hard'),
                                            ),
                                          ]);
                                    }),
                              ],
                            ),
                          ],
                        );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Countdown:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  child: StreamBuilder<String>(
                      stream: appState.countdown.outTransformed,
                      builder: (context, snapshot) {
                        return Expanded(
                          child: TextField(
                            controller: countdownController,
                            onChanged: appState.countdown.inStream,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter a value in seconds (max 60).',
                              errorText: snapshot.error,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
