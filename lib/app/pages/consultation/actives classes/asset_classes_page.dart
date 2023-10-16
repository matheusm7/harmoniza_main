import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/data/data.dart';
import 'package:harmoniza_ativos/app/pages/consultation/actives%20subclasses/asset_subclasses_page.dart';

class AssetClassesPage extends StatefulWidget {
  final String nomeCompleto;
  final String descricao;
  final List<String> selectedMedications;
  final bool isPorDiagnosticoSelected;
  final Map<String, List<String>> selectedVehicleMap;
  final bool isGestante;
  final String periodo;
  const AssetClassesPage({super.key, required this.selectedMedications, required this.isPorDiagnosticoSelected, required this.selectedVehicleMap, required this.descricao, required this.nomeCompleto, required this.isGestante, required this.periodo});

  @override
  AssetClassesPageState createState() => AssetClassesPageState();
}

class AssetClassesPageState extends State<AssetClassesPage> {
  String nomeCompleto = '';
  String descricao = '';
  bool switchValue = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  String? selectedValue = 'Diurno';
  List<int> selectedAssetClasses = [];
  Color dourado = const Color.fromARGB(255, 168, 138, 78);
  bool isAtLeastOneSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/logo.png',
                width: 150,
              ),
              const SizedBox(height: 20),
              Text(
                'CLASSE DE ATIVOS',
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
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  String categoryName = "";
                  if (index == 0) {
                    categoryName = 'Anti-acne';
                  } else if (index == 1) {
                    categoryName = 'Microbiota Cutânea';
                  } else if (index == 2) {
                    categoryName = 'Barreira Cutânea';
                  } else if (index == 3) {
                    categoryName = 'Anti-inflamatórios';
                  }
                  return CheckboxListTile(
                    activeColor: douradoEscuro,
                    title: Text(
                      categoryName,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: dourado),
                    ),
                    value: selectedAssetClasses.contains(index),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedAssetClasses.add(index);
                          isAtLeastOneSelected = true;
                        } else {
                          selectedAssetClasses.remove(index);
                        }
                      });
                    },
                  );
                },
              )),
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    if (isAtLeastOneSelected) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => AssetSubclassesPage(
                                  descricao: widget.descricao,
                                  nomeCompleto: widget.nomeCompleto,
                                  selectedVehicleMap: widget.selectedVehicleMap,
                                  isPorDiagnosticoSelected: widget.isPorDiagnosticoSelected,
                                  selectedAssetClasses: selectedAssetClasses,
                                  selectedMedications: widget.selectedMedications,
                                  isGestante: widget.isGestante,
                                  periodo: widget.periodo,
                                )),
                      );
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Selecione pelo menos uma opção'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
