import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:myapp/widgets/app_bar.dart';
import 'package:myapp/widgets/product_datail.dart';

class ProdottiPage extends StatefulWidget {
  const ProdottiPage({super.key});

  @override
  _ProdottiPageState createState() => _ProdottiPageState();
}

class _ProdottiPageState extends State<ProdottiPage> {
  final List<Map<String, String>> products = [
    {
      'title': 'pezzi_personalizzati',
      'description': 'pezzi_custom_description',
      'imagePath': 'lib/assets/custom_piexe.png',
      'detailedDescription': 'dettagli_pezzi_personalizzati',
    },
    {
      'title': 'lampade_personalizzate',
      'description': 'lampade_cartoni_animati',
      'imagePath': 'lib/assets/custom_lamp.png',
      'detailedDescription': 'dettagli_lampade_personalizzate',
    },
    {
      'title': 'portachiavi_personalizzati',
      'description': 'crea_portachiavi_unico',
      'imagePath': 'lib/assets/keychain.png',
      'detailedDescription': 'dettagli_portachiavi_personalizzati',
    },
    {
      'title': 'portachiavi_serie_preferite',
      'description': 'riproduci_personaggi',
      'imagePath': 'lib/assets/sharingan.png',
      'detailedDescription': 'dettagli_portachiavi_serie',
    },
    {
      'title': 'portachiavi_spotify',
      'description': 'ascolta_canone_preferita',
      'imagePath': 'lib/assets/spotify.png',
      'detailedDescription': 'dettagli_portachiavi_spotify',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomNavbar(
        onLanguageChange: () {
          setState(() {});
        },
      ),
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
          Container(color: Colors.black.withOpacity(0.6)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.14),
                  Text(
                    'i_nostri_prodotti'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                          _getResponsiveFontSize(screenWidth, isTitle: true),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 4.0,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int columns = 1;

                      if (constraints.maxWidth >= 600) {
                        columns = 2;
                      }

                      double cardWidth =
                          (constraints.maxWidth - (columns - 1) * 5) / columns;
                      double cardHeight = 140.0;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          childAspectRatio: cardWidth / cardHeight,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {
                              _showProductPopup(
                                context,
                                tr(product['title']!),
                                tr(product['description']!),
                                product['imagePath']!,
                                tr(product['detailedDescription']!),
                              );
                            },
                            child: _buildProductItem(
                              cardWidth,
                              cardHeight,
                              tr(product['title']!),
                              tr(product['description']!),
                              product['imagePath']!,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  if (products.isEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'nessun_prodotto_disponibile'.tr(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getResponsiveFontSize(double screenWidth, {required bool isTitle}) {
    if (isTitle) {
      if (screenWidth < 360) return 22.0;
      if (screenWidth < 480) return 24.0;
      if (screenWidth < 600) return 26.0;
      return 28.0;
    } else {
      if (screenWidth < 360) return 18.0;
      if (screenWidth < 480) return 20.0;
      if (screenWidth < 600) return 22.0;
      return 24.0;
    }
  }

  void _showProductPopup(BuildContext context, String title, String description,
      String imagePath, String detailedDescription) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductDetailPopup(
          title: title,
          description: description,
          imagePath: imagePath,
          detailedDescription: detailedDescription,
        );
      },
    );
  }

  Widget _buildProductItem(
    double cardWidth,
    double cardHeight,
    String title,
    String description,
    String imagePath,
  ) {
    double imageSize = cardHeight * 0.75;

    return Container(
      width: cardWidth,
      height: cardHeight,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 0.5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              height: imageSize,
              width: imageSize,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titolo
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(
                          MediaQuery.of(context).size.width,
                          isTitle: true),
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4), // Spazio tra titolo e descrizione
                // Descrizione
                Flexible(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(
                          MediaQuery.of(context).size.width,
                          isTitle: false),
                      color: Colors.black54,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8), // Spazio prima del link
                // Link "Leggi di più"
                GestureDetector(
                  onTap: () {
                    // Azione per il click su "Leggi di più"
                    _showProductPopup(
                      context,
                      title,
                      description,
                      imagePath,
                      description, // Puoi passare una descrizione più dettagliata se disponibile
                    );
                  },
                  child: Text(
                    'Leggi di più',
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(
                          MediaQuery.of(context).size.width,
                          isTitle: false),
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
