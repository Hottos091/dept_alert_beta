import 'package:dept_alert_beta/presentation/screens/new_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:dept_alert_beta/presentation/screens/home_screen.dart';


class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    //final Object? key = settings.arguments;
    
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const NewContactScreen(
            title: "NewContactScreen #1",
          ),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(//TODO Swap screens when navigation will be added
            title: "HomeScreen #1",
          ),
        );
        
      default:
        return null;
    }
  }
}