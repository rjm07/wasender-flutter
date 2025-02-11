import 'package:flutter/material.dart';

class NavService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void pop({
    int? pages,
  }) {
    final BuildContext? context = navigatorKey.currentContext;

    if (context != null) {
      if (pages != null) {
        for (int i = 0; i < pages; i++) {
          Navigator.of(context).pop();
        }
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  static void showSnackBar({
    String? errorMessage,
  }) {
    final BuildContext? context = navigatorKey.currentContext;

    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(errorMessage!),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void popToRoot() {
    final BuildContext? context = navigatorKey.currentContext;

    if (context != null) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  static void push({
    required Widget screen,
  }) {
    final BuildContext? context = navigatorKey.currentContext;

    if (context != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => screen,
        ),
      );
    }
  }

  static void jumpToPage(int page) {
    final BuildContext? context = navigatorKey.currentContext;

    if (context != null) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  static void jumpToPageID(String pageID) {
    final BuildContext? context = navigatorKey.currentContext;

    if (context != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        pageID,
        (route) => false, // Clear all other routes
      );
    }
  }

  static void popUntilAndPush({
    required String popUntilRoute,
    required Widget pushScreen,
  }) {
    final BuildContext? context = navigatorKey.currentContext;

    if (context != null) {
      Navigator.of(context).popUntil((route) => route.settings.name == popUntilRoute);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => pushScreen,
        ),
      );
    }
  }
}
