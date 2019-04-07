import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'src/homepage.dart';
import 'src/models/appstate.dart';
import 'src/models/theme.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AppStateProvider<AppState>(
      appState: appState,
      child: MaterialPage(),
    );
  }
}

class MaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = AppStateProvider.of<AppState>(context).currentTheme;

    return ValueBuilder<MyTheme>(
        streamed: theme,
        builder: (context, snapshot) {
          return MaterialApp(
              title: 'Trivia example',
              theme: _buildThemeData(snapshot.data),
              home: HomePage());
        });
  }

  ThemeData _buildThemeData(MyTheme appTheme) {
    return ThemeData(
      brightness: appTheme.brightness,
      backgroundColor: appTheme.backgroundColor,
      scaffoldBackgroundColor: appTheme.scaffoldBackgroundColor,
      primaryColor: appTheme.primaryColor,
      primaryColorBrightness: appTheme.primaryColorBrightness,
      accentColor: appTheme.accentColor,
    );
  }
}
