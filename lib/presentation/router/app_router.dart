import 'package:dept_alert_beta/presentation/screens/new_contact_screen.dart';
import 'package:dept_alert_beta/presentation/screens/update_contact_screen.dart';
import 'package:dept_alert_beta/model/contact.dart';


import 'package:flutter/material.dart';


class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Contact;
    //final Object? key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const NewContactScreen(
            title: "NewContactScreen",
          ),
        );
      case '/update':
        return MaterialPageRoute(
          builder: (_) => UpdateContactScreen(
              title: "Updating User",
              contactToUpdate: arguments),
          );

      default:
        return null;
    }
  }
}