import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../actives page/actives.dart';

class AssetSubclassesPage extends StatefulWidget {
  final String nomeCompleto;
  final String descricao;
  final List<int> selectedAssetClasses;
  final List<String> selectedMedications;
  final bool isPorDiagnosticoSelected;
  final Map<String, List<String>> selectedVehicleMap;
  final bool isGestante;
  final String periodo;
  const AssetSubclassesPage({
    Key? key,
    required this.selectedAssetClasses,
    required this.selectedMedications,
    required this.isPorDiagnosticoSelected,
    required this.selectedVehicleMap,
    required this.descricao,
    required this.nomeCompleto,
    required this.isGestante,
    required this.periodo,
  }) : super(key: key);

  @override
  AssetSubclassesPageState createState() => AssetSubclassesPageState();
}

class AssetSubclassesPageState extends State<AssetSubclassesPage> {
  String nomeCompleto = '';
  String descricao = '';
  bool switchValue = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  String? selectedValue = 'Diurno';
  Color dourado = const Color.fromARGB(255, 168, 138, 78);
  List<List<String>> subclasses = [
    ['C.ACNESS', 'DHT'],
    ['Antisséptico', 'Bactericida'],
    ['AQP-3', 'Cálcio'],
    ['Corticoide-Like', 'Inflamação Neurogênica'],
  ];
  List<List<bool>> selectedSubclasses = [];

  List<String> classNames = [
    'Anti-Acne',
    'Microbiota Cutânea',
    'Barreira Cutânea',
    'Anti-inflamatório',
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < subclasses.length; i++) {
      selectedSubclasses.add(List<bool>.filled(subclasses[i].length, false));
    }
  }

  void navigateToActivesPage() {
    List<String> selectedTexts = [];
    List<String> selectedClassNames = [];

    for (int i = 0; i < selectedSubclasses.length; i++) {
      for (int j = 0; j < selectedSubclasses[i].length; j++) {
        if (selectedSubclasses[i][j]) {
          selectedTexts.add(getSelectedText(i, j));
          selectedClassNames.add(classNames[i]);
        }
      }
    }

    if (selectedTexts.isEmpty) {
      for (int i = 0; i < subclasses.length; i++) {
        selectedTexts.addAll(subclasses[i]);
        selectedClassNames.addAll(List<String>.filled(subclasses[i].length, classNames[i]));
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivesPage(
          descricao: widget.descricao,
          nomeCompleto: widget.nomeCompleto,
          selectedVehicleMap: widget.selectedVehicleMap,
          isPorDiagnosticoSelected: widget.isPorDiagnosticoSelected,
          subclasses: selectedTexts,
          classNames: selectedClassNames,
          selectedMedications: widget.selectedMedications,
          isGestante: widget.isGestante,
          periodo: widget.periodo,
        ),
      ),
    );
  }

  String getSelectedText(int assetClassIndex, int subclassIndex) {
    return subclasses[assetClassIndex][subclassIndex];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/logo.png',
                width: 150,
              ),
              const SizedBox(height: 20),
              Text(
                'SUBCLASSES (Opcional)',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: dourado,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.selectedAssetClasses.length,
                  itemBuilder: (BuildContext context, int index) {
                    int assetClassIndex = widget.selectedAssetClasses[index];
                    List<String> assetSubclasses = subclasses[assetClassIndex];

                    String className = classNames[assetClassIndex];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                '• ',
                                style: TextStyle(color: dourado),
                              ),
                              Text(
                                className,
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: dourado),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: assetSubclasses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                              activeColor: dourado,
                              title: Text(
                                assetSubclasses[index],
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w300, color: dourado),
                              ),
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
                  onTap: navigateToActivesPage,
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
                    Navigator.pop(context);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
