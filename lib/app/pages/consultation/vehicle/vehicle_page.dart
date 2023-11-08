import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/pages/consultation/pdf%20page/generate_pdf.dart';
import 'package:provider/provider.dart';

import 'historic.dart';

class VehiclePage extends StatefulWidget {
  final String nomeCompleto;
  final String descricao;
  final List<String> selectedMedications;
  final bool isPorDiagnosticoSelected;
  final Map<String, List<String>> selectedVehicleMap;
  final List<String> selectedActives;
  final bool isGestante;
  final String periodo;

  const VehiclePage({
    Key? key,
    required this.selectedMedications,
    required this.isPorDiagnosticoSelected,
    required this.selectedVehicleMap,
    required this.selectedActives,
    required this.descricao,
    required this.nomeCompleto,
    required this.isGestante,
    required this.periodo,
  }) : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  List<String> _selectedVehicles = [];
  bool isVehicleSelectionValid = true;
  String nomeCompleto = '';
  String descricao = '';
  String? selectedValue = 'Diurno';
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  Color douradoEscuro = const Color.fromARGB(255, 168, 138, 78);

  List<Map<String, String>> infoList = [
    {
      'subclass': 'Veiculo 1',
      'text1': 'Mecanismo de ação: ',
      'text2': 'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde',
      'text3': '5.0 - 7.0',
      'text4': 'Info 1',
      'subtitle': 'subtitulo 1',
    },
    {
      'subclass': 'Veiculo 2',
      'text1': 'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde.',
      'text2': 'Mais informações 2',
      'text3': '0.3 a 5.0',
      'text4': 'Info 2',
      'subtitle': 'subtitulo 2',
    },
    {
      'subclass': 'Veiculo 3',
      'text1': 'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde',
      'text2': 'Mais informações 3',
      'text3': '7.0 - 9.0',
      'text4': 'Info 3',
      'subtitle': 'subtitulo 3',
    },
    {
      'subclass': 'Veiculo 4',
      'text1': 'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde',
      'text2': 'Mais informações 4',
      'text3': '6.0 - 7.5',
      'text4': 'Info 4',
      'subtitle': 'subtitulo 4',
    },
  ];

  Map<String, int> subclassIndexMap = {
    'Veiculo 1': 0,
    'Veiculo 2': 1,
    'Veiculo 3': 2,
    'Veiculo 4': 3,
  };

  @override
  void initState() {
    super.initState();

    _selectedVehicles = List.filled(widget.selectedMedications.length, '');

    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  void _updateSelectedVehicle(String selectedMedication, String selectedVehicle) {
    setState(() {
      if (widget.isPorDiagnosticoSelected) {
        widget.selectedVehicleMap[selectedMedication] = [];

        if (selectedVehicle.isNotEmpty) {
          widget.selectedVehicleMap[selectedMedication] = [selectedVehicle];
        }

        for (String medication in widget.selectedMedications) {
          if (medication != selectedMedication) {
            widget.selectedVehicleMap[medication] = [];
          }
        }
      } else {
        if (selectedVehicle.isNotEmpty) {
          widget.selectedVehicleMap[selectedMedication] = [selectedVehicle];
          _selectedVehicles[widget.selectedMedications.indexOf(selectedMedication)] = selectedVehicle;
        } else {
          widget.selectedVehicleMap[selectedMedication] = [];
          _selectedVehicles[widget.selectedMedications.indexOf(selectedMedication)] = '';
        }
      }
    });
  }

  void showInfoDialog(BuildContext context, int index) {
    String subclass = infoList[index]['subclass']!;
    int infoIndex = subclassIndexMap[subclass]!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            subclass,
            textAlign: TextAlign.center,
            style: TextStyle(color: douradoEscuro),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                infoList[infoIndex]['text1']!,
                style: TextStyle(fontWeight: FontWeight.bold, color: douradoEscuro),
              ),
              const SizedBox(height: 8),
              Text(
                infoList[infoIndex]['text2']!,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'PH de estabilidade: ',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: douradoEscuro),
                  ),
                  Text(
                    infoList[infoIndex]['text3']!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Dosagem usual: ',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: douradoEscuro),
                  ),
                  Text(
                    infoList[infoIndex]['text4']!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Fechar',
                style: TextStyle(color: douradoEscuro, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final historicConsultationState = Provider.of<HistoricConsultationState>(context, listen: false);

    final String nomeCompleto = widget.nomeCompleto;
    final String descricao = widget.descricao;
    final String periodo = widget.periodo;
    final List<String> selectedActives = widget.selectedActives;

    historicConsultationState.setHistoricConsultationInfo(
      userUID: FirebaseAuth.instance.currentUser?.uid ?? '',
      nomeCompleto: nomeCompleto,
      descricao: descricao,
      isGestante: widget.isGestante,
      periodo: widget.periodo,
      selectedActives: widget.selectedActives,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Image.asset('assets/logo.png', width: 150),
          const SizedBox(height: 20),
          Text(
            'Veículo (Opcional)',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: douradoEscuro,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          _showMessage(),
          const SizedBox(height: 5),
          Expanded(
            child: widget.isPorDiagnosticoSelected
                ? PageView.builder(
                    controller: _pageController,
                    itemCount: widget.selectedMedications.length,
                    itemBuilder: (BuildContext context, int index) {
                      String selectedMedication = widget.selectedMedications[index];
                      return buildVehiclesPage(selectedMedication);
                    },
                  )
                : buildVehiclesPage(widget.selectedMedications.first),
          ),
        ],
      ),
    );
  }

  Widget buildVehiclesPage(String selectedMedication) {
    List<String> selectedVehicles = widget.selectedVehicleMap[selectedMedication] ?? [];
    List<String> availableVehicles = infoList.map((info) => info['subclass']!).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: availableVehicles.length,
                itemBuilder: (BuildContext context, int index) {
                  String vehicle = availableVehicles[index];
                  bool isVehicleSelected = selectedVehicles.contains(vehicle);

                  return CheckboxListTile(
                    activeColor: douradoEscuro,
                    checkColor: Colors.white,
                    value: isVehicleSelected,
                    onChanged: (bool? newValue) {
                      setState(() {
                        if (widget.isPorDiagnosticoSelected) {
                          if (newValue!) {
                            widget.selectedVehicleMap[selectedMedication] = [vehicle];
                          } else {
                            widget.selectedVehicleMap[selectedMedication] = [];
                          }
                        } else {
                          if (newValue!) {
                            _updateSelectedVehicle(selectedMedication, vehicle);
                          } else {
                            _updateSelectedVehicle(selectedMedication, '');
                          }
                        }
                      });
                    },
                    title: Text(
                      vehicle,
                      style: TextStyle(fontWeight: FontWeight.bold, color: douradoEscuro),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () {
                        showInfoDialog(context, index);
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  bool atLeastOneMedicationSelected = false;
                  for (String medication in widget.selectedMedications) {
                    if (widget.selectedVehicleMap[medication] != null && widget.selectedVehicleMap[medication]!.isNotEmpty) {
                      atLeastOneMedicationSelected = true;
                      break;
                    }
                  }

                  if (!atLeastOneMedicationSelected) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Erro'),
                          content: const Text('Por favor, selecione pelo menos um veículo.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    if (widget.isPorDiagnosticoSelected) {
                      bool allMedicationsSelected = true;
                      for (String medication in widget.selectedMedications) {
                        if (widget.selectedVehicleMap[medication]!.isEmpty) {
                          allMedicationsSelected = false;
                          break;
                        }
                      }

                      if (allMedicationsSelected) {
                        String selectedVehicle = widget.selectedVehicleMap[widget.selectedMedications[_currentPageIndex]]!.first;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GeneratePdf(
                              selectedActives: widget.selectedActives,
                              descricao: widget.descricao,
                              nomeCompleto: widget.nomeCompleto,
                              isGestante: widget.isGestante,
                              periodo: widget.periodo,
                              selectedVehicle: selectedVehicle,
                              selectedVehicleMap: widget.selectedVehicleMap,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Erro'),
                              content: const Text('Por favor, selecione pelo menos um veículo para cada medicação.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      String selectedVehicle = widget.selectedVehicleMap[widget.selectedMedications.first]!.first;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GeneratePdf(
                            selectedActives: widget.selectedActives,
                            descricao: widget.descricao,
                            nomeCompleto: widget.nomeCompleto,
                            isGestante: widget.isGestante,
                            periodo: widget.periodo,
                            selectedVehicle: selectedVehicle,
                            selectedVehicleMap: widget.selectedVehicleMap,
                          ),
                        ),
                      );
                    }
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

  Widget _showMessage() {
    if (widget.isPorDiagnosticoSelected) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.selectedMedications.map((medication) {
            int index = widget.selectedMedications.indexOf(medication);

            String selectedVehicle = _selectedVehicles[index];
            List<String> selectedVehicles = widget.selectedVehicleMap[medication] ?? [];
            String selectedVehicleText = selectedVehicles.isNotEmpty ? selectedVehicles.join(', ') : 'Nenhum veículo selecionado';

            return Column(
              children: [
                Text(
                  medication,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                Text(
                  selectedVehicleText,
                )
              ],
            );
          }).toList(),
        ),
      );
    } else {
      String selectedMedicationsText = widget.selectedMedications.join(', ');

      List<String> selectedVehicles = widget.selectedVehicleMap[widget.selectedMedications.first] ?? [];
      String selectedVehicleText = selectedVehicles.isNotEmpty ? selectedVehicles.join(', ') : 'Nenhum veículo selecionado';

      return Column(
        children: [
          Text(
            selectedMedicationsText,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          Text(selectedVehicleText),
        ],
      );
    }
  }
}
