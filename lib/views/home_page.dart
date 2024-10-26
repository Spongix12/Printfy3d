import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:myapp/widgets/app_bar.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  void _updateLanguage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double titleFontSize = screenWidth > 800 ? 40 : screenWidth * 0.08;
    final double subtitleFontSize = screenWidth > 800 ? 20 : screenWidth * 0.05;
    final double buttonPadding = screenWidth > 800 ? 20 : 15;
    final double buttonFontSize = screenWidth > 800 ? 18 : screenWidth * 0.04;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomNavbar(onLanguageChange: _updateLanguage),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/3d-printer-bg.webp'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(seconds: 2),
                  child: Text(
                    'welcome'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          offset: const Offset(3.0, 3.0),
                          blurRadius: 6.0,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(seconds: 2),
                  child: Text(
                    'subtitle'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 1.2,
                      height: 1.4,
                      shadows: [
                        Shadow(
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 4.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(seconds: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(
                        context,
                        'products'.tr(),
                        '/products',
                        buttonPadding,
                        buttonFontSize,
                      ),
                      const SizedBox(width: 20),
                      _buildButton(
                        context,
                        'contactus'.tr(),
                        '/contacts',
                        buttonPadding,
                        buttonFontSize,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildButton(
    BuildContext context,
    String label,
    String route,
    double padding,
    double fontSize,
  ) {
    return ElevatedButton(
      onPressed: () {
        context.go(route); // Usa GoRouter per la navigazione
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: padding * 2, vertical: padding),
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        shadowColor: Colors.black,
        elevation: 8,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
