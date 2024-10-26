import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/views/contact.dart';
import 'package:myapp/views/home_page.dart';
import 'package:myapp/views/product.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LandingPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'products',
          builder: (BuildContext context, GoRouterState state) {
            return const ProdottiPage();
          },
        ),
        GoRoute(
          path: 'contacts',
          builder: (BuildContext context, GoRouterState state) {
            return const ContactPage();
          },
        ),
      ],
    ),
  ],
);
