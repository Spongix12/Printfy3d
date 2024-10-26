import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailPopup extends StatelessWidget {
  final String title;
  final String description;
  final String detailedDescription;
  final String imagePath;

  const ProductDetailPopup({
    super.key,
    required this.title,
    required this.description,
    required this.detailedDescription,
    required this.imagePath,
  });

  // Funzione per aprire WhatsApp
  Future<void> _launchWhatsApp() async {

    const whatsappUrl = "https://cbl.link/t9ph9Bs";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isWeb = screenWidth > 600; // Verifica se è layout desktop

    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: isWeb ? screenWidth * 0.5 : screenWidth * 0.9, // Ridotta larghezza per il web
          padding: EdgeInsets.all(isWeb ? screenWidth * 0.02 : screenWidth * 0.05),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 1,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    imagePath,
                    height: isWeb ? screenHeight * 0.2 : screenHeight * 0.25,
                    width: isWeb ? screenWidth * 0.4 : screenWidth * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                title,
                style: TextStyle(
                  fontSize: isWeb ? screenWidth * 0.035 : screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                detailedDescription,
                style: TextStyle(
                  fontSize: isWeb ? screenWidth * 0.03 : screenWidth * 0.045,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.5,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton(
                    context,
                    onPressed: () => Navigator.pushNamed(context, '/contact'),
                    backgroundColor: Colors.blue.shade700,
                    icon: Image.asset(
                      'lib/assets/icons/icons8-email-50.png',
                      height: isWeb ? screenWidth * 0.04 : screenWidth * 0.05,
                      width: isWeb ? screenWidth * 0.04 : screenWidth * 0.05,
                      color: Colors.white,
                    ),
                    text: 'contact_us'.tr(),
                    isWeb: isWeb,
                  ),
                  _buildButton(
                    context,
                    onPressed: _launchWhatsApp,
                    backgroundColor: Colors.green.shade600,
                    icon: Image.asset(
                      'lib/assets/icons/whatsapp.png',
                      height: isWeb ? screenWidth * 0.04 : screenWidth * 0.05,
                      width: isWeb ? screenWidth * 0.04 : screenWidth * 0.05,
                      color: Colors.white,
                    ),
                    text: 'whatsapp'.tr(),
                    isWeb: isWeb,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget per il pulsante con animazione
  Widget _buildButton(
    BuildContext context, {
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Widget icon,
    required String text,
    required bool isWeb,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Flexible(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isWeb ? screenWidth * 0.35 : screenWidth * 0.45,
          child: ElevatedButton.icon(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: icon,
            label: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isWeb ? screenWidth * 0.03 : screenWidth * 0.04,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
