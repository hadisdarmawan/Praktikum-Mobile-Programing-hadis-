import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/form_screen.dart';
import '../models/note_model.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );

      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          settings: settings,
        );

      case '/form':
        final args = settings.arguments;

        if (args is Note) {
          return MaterialPageRoute(
            builder: (context) => FormScreen(initialNote: args),
            settings: settings,
          );
        } else if (args == null) {
          return MaterialPageRoute(
            builder: (context) => const FormScreen(),
            settings: settings,
          );
        }
        // Jika arguments bukan Note dan bukan null
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Invalid arguments type')),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('404')),
            body: Center(child: Text('Route ${settings.name} not found')),
          ),
        );
    }
  }
}
