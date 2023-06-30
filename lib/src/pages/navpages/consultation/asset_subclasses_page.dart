import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/src/pages/navpages/actives.dart';

import 'asset_classes_page.dart';

class AssetSubclassesPage extends StatefulWidget {
  final List<int> selectedAssetClasses;

  const AssetSubclassesPage({super.key, required this.selectedAssetClasses});

  @override
  _AssetSubclassesPageState createState() => _AssetSubclassesPageState();
}

class _AssetSubclassesPageState extends State<AssetSubclassesPage> {
  Color dourado = const Color.fromARGB(255, 168, 138, 78);
  List<List<String>> subclasses = [
    ['Corolla', 'Ferrari 458', 'Porsche 911'],
    ['Nike', 'Adidas', 'Puma', 'Gucci'],
    ['Arroz', 'Feijão', 'Macarrão', 'Batata'],
    ['Energetico', 'Refrigerante', 'Cerveja', 'Vinho'],
  ];
  List<List<bool>> selectedSubclasses = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < subclasses.length; i++) {
      selectedSubclasses.add(List<bool>.filled(subclasses[i].length, false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/logo.png',
                width: 150,
              ),
              const SizedBox(height: 20),
              Text(
                'SUBCLASSES (Opcional)',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: dourado,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.selectedAssetClasses.length,
                  itemBuilder: (BuildContext context, int index) {
                    int assetClassIndex = widget.selectedAssetClasses[index];
                    List<String> assetSubclasses = subclasses[assetClassIndex];

                    String className = "";
                    if (assetClassIndex == 0) {
                      className = 'Carros';
                    } else if (assetClassIndex == 1) {
                      className = 'Marcas';
                    } else if (assetClassIndex == 2) {
                      className = 'Comidas';
                    } else if (assetClassIndex == 3) {
                      className = 'Bebidas';
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            className,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: assetSubclasses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                              title: Text(assetSubclasses[index]),
                              value: selectedSubclasses[assetClassIndex][index],
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedSubclasses[assetClassIndex][index] = value ?? false;
                                });
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivesPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: dourado,
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'CONTINUAR',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AssetClassesPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: dourado,
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'VOLTAR',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
