import 'package:flutter/material.dart';
import 'package:myapp/views/contact.dart'; // Import your Contact page
import 'package:myapp/views/home_page.dart'; // Import your LandingPage
import 'package:myapp/views/product.dart'; // Import your Product page

class AppRoutes {
  // Define route names
  static const String landing = '/';
  static const String prodotti = '/prodotti';
  static const String contatti = '/contatti';

  // Generate routes based on route name
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landing:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case prodotti:
        return MaterialPageRoute(builder: (_) => const ProdottiPage());
      case contatti:
        return MaterialPageRoute(builder: (_) => const ContactPage());
      default:
        return _errorRoute(); // Fallback route in case of an invalid route
    }
  }

  // Method for the error route
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Page not found!'),
        ),
      ),
    );
  }
}
