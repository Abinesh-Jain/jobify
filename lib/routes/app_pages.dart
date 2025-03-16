import 'package:flutter/material.dart';

import '../pages/auth_page.dart';
import '../pages/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, Widget Function(BuildContext)> get pages => {
        AppRoutes.auth: (context) => const AuthPage(),
        AppRoutes.home: (context) => const HomePage(),
      };
}
