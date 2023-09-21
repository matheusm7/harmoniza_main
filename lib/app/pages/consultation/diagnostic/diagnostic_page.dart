import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/data/data.dart';

import '../actives classes/asset_classes_page.dart';

class DiagnosticPage extends StatefulWidget {
  final String nomeCompleto;
  final String descricao;
  final bool isGestante;
  final String periodo;
  const DiagnosticPage({Key? key, required this.descricao, required this.nomeCompleto, required this.isGestante, required this.periodo}) : super(key: key);

  @override
  State<DiagnosticPage> createState() => _DiagnosticPageState();
}

class _DiagnosticPageState extends State<DiagnosticPage> {
  final List<bool> _isCheckedList = [false, false, false, false, false];
  Color douradoEscuro = const Color.fromARGB(255, 168, 138, 78);
  String _selectedOption = 'única';
  List<String> selectedMedications = [];
  Map<String, List<String>> selectedVehicleMap = {}; // Atualizado para um mapa de listas de veículos
  bool _isPorDiagnosticoSelected = false;
  String nomeCompleto = '';
  String descricao = '';
  bool switchValue = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  String? selectedValue = 'Diurno';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'DIAGNÓSTICO',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: douradoEscuro,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  activeColor: douradoEscuro,
                  value: 'única',
                  groupValue: _selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOption = value ?? 'única';
                    });
                  },
                ),
                const Text('Única'),
                Radio<String>(
                  activeColor: douradoEscuro,
                  focusColor: dourado,
                  value: 'por diagnostico',
                  groupValue: _selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOption = value ?? 'única';
                      _isPorDiagnosticoSelected = _selectedOption == 'por diagnostico';
                    });
                  },
                ),
                const Text('Por diagnóstico'),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  String checkboxName = '';
                  if (index == 0) {
                    checkboxName = 'Medicação A';
                  } else if (index == 1) {
                    checkboxName = 'Medicação B';
                  } else if (index == 2) {
                    checkboxName = 'Medicação C';
                  } else if (index == 3) {
                    checkboxName = 'Medicação D';
                  } else if (index == 4) {
                    checkboxName = 'Medicação E';
                  }

                  return CheckboxListTile(
                    activeColor: douradoEscuro,
                    value: _isCheckedList[index],
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isCheckedList[index] = newValue ?? false;
                      });
                    },
                    title: Text(
                      checkboxName,
                      style: TextStyle(fontWeight: FontWeight.bold, color: douradoEscuro),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  List<String> selectedMedications = [];
                  Map<String, List<String>> selectedVehicleMap = {}; // Usar um mapa de listas de veículos

                  for (int i = 0; i < _isCheckedList.length; i++) {
                    if (_isCheckedList[i]) {
                      String medicationName = '';
                      switch (i) {
                        case 0:
                          medicationName = 'Medicação A';
                          break;
                        case 1:
                          medicationName = 'Medicação B';
                          break;
                        case 2:
                          medicationName = 'Medicação C';
                          break;
                        case 3:
                          medicationName = 'Medicação D';
                          break;
                        case 4:
                          medicationName = 'Medicação E';
                          break;
                      }
                      selectedMedications.add(medicationName);
                      selectedVehicleMap[medicationName] = []; // Inicializar com uma lista vazia de veículos
                    }
                  }

                  if ((_isPorDiagnosticoSelected && selectedMedications.length <= 1) || (!_isPorDiagnosticoSelected && selectedMedications.isEmpty)) {
                    String errorMessage = _isPorDiagnosticoSelected ? 'Selecione mais de uma medicação.' : 'Selecione pelo menos um medicamento.';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(errorMessage)),
                    );
                  } else {
                    selectedMedications = selectedMedications;
                    selectedVehicleMap = selectedVehicleMap; // Atualizar o mapa de veículos selecionados
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssetClassesPage(
                          selectedMedications: selectedMedications,
                          isPorDiagnosticoSelected: _isPorDiagnosticoSelected,
                          selectedVehicleMap: selectedVehicleMap,
                          descricao: widget.descricao,
                          nomeCompleto: widget.nomeCompleto,
                          isGestante: widget.isGestante,
                          periodo: widget.periodo,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: douradoEscuro,
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
                    color: douradoEscuro,
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
    );
  }
}
