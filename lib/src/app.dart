import 'package:flutter/material.dart';

import '../config/app_theme.dart';
import '../routes/app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppPages.pages,
      theme: AppTheme.theme,
    );
  }
}
