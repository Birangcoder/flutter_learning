import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'routes.dart'; // ✅ Don't forget to import routes.dart
import 'routes/home_page.dart';
import 'routes/random_page.dart';
import 'routes/iconAnim.dart';
import 'model/todo_model.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String randomPage = '/random';
  static const String iconAnimPage = '/iconAnim';
  // final todoList = RouteSettings.arguments;
  RouteGenerator._(); // ✅ private constructor

  static Route<dynamic> generateRoute(RouteSettings settings) {
  Widget page;
    switch (settings.name) {
      case homePage:
        page= const HomePage();
        break;
        // return MaterialPageRoute(
        //   builder: (_) => const HomePage(),
        // );
      case randomPage:
        page= const RandomPage();
        break;
        // return MaterialPageRoute(
        //   builder: (_) => const RandomPage(), // Provider will provide the todo
        // );
      case iconAnimPage:
        page = const IconAnimPage();
        break;
    // return MaterialPageRoute(
    //   builder: (_) => const RandomPage(), // Provider will provide the todo
    // );
      default:
        throw const RouteException("Route not found");
    }
    return pageAnimation(page);
  }

  static PageRouteBuilder pageAnimation(Widget page)
  {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), // from right
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutSine,
          ));
        return SlideTransition(
          position: offsetAnimation,
          // opacity: animation,
          child: child,
        );
      }
    );
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
