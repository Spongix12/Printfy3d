import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:device_preview/device_preview.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/routes/go_router.dart'; // Import the router configuration

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Abilita solo in modalità debug
      builder: (context) => EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('it')],
        path: 'lib/langs', // Cartella in cui sono presenti i file di traduzione
        fallbackLocale: const Locale('it'), // Locale di fallback
        child: MyApp(router: appRouter), // Pass the router to MyApp
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '3D Store',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale, // Utilizza il locale corrente di EasyLocalization
      routerConfig: router, // Configura il router
      builder: DevicePreview.appBuilder, // Aggiungi il builder di Device Preview
    );
  }
}
