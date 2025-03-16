import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jobify/routes/app_routes.dart';
import 'package:jobify/services/auth_service.dart';
import 'package:jobify/snackbars/app_snackbar.dart';

import '../utils/form_keys.dart';

class AuthController extends ChangeNotifier {
  final BuildContext context;

  final AuthService _authService = AuthService();

  AuthController(this.context);

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  bool isLogin = true;

  void init() async {
    await Future.delayed(Duration.zero);
    if (_authService.currentUser != null) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    }
  }

  void toggleLogin() {
    isLogin = !isLogin;
    notifyListeners();
  }

  void onSubmit() {
    final valid = formKey.currentState?.saveAndValidate();
    if (valid == true) {
      final values = formKey.currentState?.value;
      final email = values?[FormKeys.email];
      final password = values?[FormKeys.password];
      if (isLogin) {
        signInWithEmailPassword(email, password);
      } else {
        signUpWithEmailPassword(email, password);
      }
    }
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    final user = await _authService.signInWithEmailPassword(email, password,
        onError: errorHandler);
    if (user != null && context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
      AppSnackbar.showSnackbar(
          context, 'Welcome ${user.displayName ?? user.email}');
    }
  }

  Future<void> signUpWithEmailPassword(String email, String password) async {
    final user = await _authService.signUpWithEmailPassword(email, password,
        onError: errorHandler);
    if (user != null && context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
      AppSnackbar.showSnackbar(
          context, 'Welcome ${user.displayName ?? user.email}');
    }
  }

  void errorHandler(e) {
    if (e is FirebaseAuthException) {
      if (context.mounted) AppSnackbar.showSnackbar(context, e.message ?? '');
    }
  }

  void continueWithGoogle() async {
    final user = await _authService.signInWithGoogle(onError: errorHandler);
    if (user != null && context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
      AppSnackbar.showSnackbar(
          context, 'Welcome ${user.displayName ?? user.email}');
    }
  }
}
