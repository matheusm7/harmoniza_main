import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/data/data.dart';
import 'package:harmoniza_ativos/app/pages/consultation/pdf%20page/pdf_page.dart';

import '../actives page/actives.dart';

class GeneratePdf extends StatefulWidget {
  final String nomeCompleto;
  final String descricao;
  final List<String> selectedActives;
  final String selectedVehicle;
  final Map<String, List<String>> selectedVehicleMap;
  final bool isGestante;
  final String periodo;

  const GeneratePdf({
    Key? key,
    required this.selectedActives,
    required this.selectedVehicle,
    required this.selectedVehicleMap,
    required this.descricao,
    required this.nomeCompleto,
    required this.isGestante,
    required this.periodo,
  }) : super(key: key);

  @override
  State<GeneratePdf> createState() => _GeneratePdfState();
}

class _GeneratePdfState extends State<GeneratePdf> {
  List<String> valoresDosCampos = [];
  late List<TextEditingController> _controllers;
  late List<String> errorMessages;
  int currentIndex = -1;
  String nomeCompleto = '';
  String descricao = '';
  bool switchValue = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  String? selectedValue = 'Diurno';
  final Map<String, String> observacoesVeiculos = {};

  @override
  void initState() {
    super.initState();
    valoresDosCampos = List.filled(widget.selectedActives.length, '');
    _controllers = List.generate(
      widget.selectedActives.length,
      (index) => TextEditingController(),
    );
    errorMessages = List.filled(widget.selectedActives.length, '');
  }

  void _validateInput(String value, int i) {
    if (value.isNotEmpty) {
      double parsedValue = double.tryParse(value) ?? 0;

      int infoIndex = subclassIndexMap[widget.selectedActives[i]]!;
      double min = double.tryParse(infoList[infoIndex]['min']!) ?? 0;
      double max = double.tryParse(infoList[infoIndex]['max']!) ?? 0;

      if (parsedValue >= min && parsedValue <= max) {
        setState(() {
          errorMessages[i] = '';
        });
      } else {
        setState(() {
          errorMessages[i] = 'Valor fora do intervalo recomendado';
        });
      }

      setState(() {
        valoresDosCampos[i] = value;
      });
    } else {
      setState(() {
        errorMessages[i] = '';
        valoresDosCampos[i] = '';
      });
    }
  }

  void _showVehicleInfoDialog(BuildContext context, List<String> vehicles) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Informações dos Veículos Selecionados',
            textAlign: TextAlign.center,
            style: TextStyle(color: douradoEscuro),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: vehicles.map((vehicle) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle,
                    style: TextStyle(fontWeight: FontWeight.bold, color: douradoEscuro),
                  ),
                ],
              );
            }).toList(),
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

  String getShortDescription(String fullDescription, int maxLength) {
    if (fullDescription.length <= maxLength) {
      return fullDescription;
    } else {
      return "${fullDescription.substring(0, maxLength)}...";
    }
  }

  List<Map<String, String>> infoList = [
    {
      'subclass': 'Acne less',
      'text1': 'Acne Less é um tratamento revolucionário para acne que promove a redução efetiva da inflamação e eliminação das espinhas. Sua fórmula avançada combate as causas da acne, regulando a produção de sebo e desobstruindo os poros, proporcionando uma pele mais saudável e livre de imperfeições. Com resultados visíveis em poucas semanas, Acne Less é a solução ideal para quem busca uma pele limpa e sem acne.',
      'text2': 'text2',
      'text3': '5.0 - 7.0',
      'text4': '0.5 a 7',
      'min': '0.3',
      'max': '0.7',
    },
    {
      'subclass': 'Acnebiol',
      'text1': 'Acnebiol é um medicamento utilizado no tratamento da acne, que age diminuindo a produção de sebo e combatendo a inflamação da pele. Sua fórmula inclui substâncias como o ácido salicílico e o peróxido de benzoíla, que ajudam a reduzir a formação de cravos e espinhas, proporcionando uma pele mais saudável e livre de acne.',
      'text2': 'Outra informação sobre DHT',
      'text3': '0.3 a 5.0',
      'text4': '',
      'min': '2.0',
      'max': '5.0',
    },
    {
      'subclass': 'Antisséptico',
      'text1': 'Um antisséptico é uma substância que interrompe ou retarda o crescimento de micro-organismos. Ele é usado com frequência ​​em hospitais e outros ambientes médicos para reduzir o risco de infecção durante a cirurgia e outros procedimentos.',
      'text2': 'Outra informação sobre ',
      'text3': 'teste',
      'text4': '',
      'min': '4.0',
      'max': '5.0',
    },
    {
      'subclass': 'Bactericida',
      'text1': 'Descrição Bactericida',
      'text2': 'Outra informação sobre ',
      'text3': 'teste',
      'text4': '',
      'min': '6.0',
      'max': '9.0',
    },
    {
      'subclass': 'AQP-3',
      'text1': 'Descrição AQP-3',
      'text2': 'Outra informação sobre ',
      'text3': 'teste',
      'text4': '',
      'min': '3.0',
      'max': '8.0',
    },
    {
      'subclass': 'Cálcio',
      'text1': 'Descrição Cálcio',
      'text2': 'Outra informação sobre ',
      'text3': 'teste',
      'text4': '',
      'min': '4.0',
      'max': '8.0',
    },
    {
      'subclass': 'Corticoide-Like',
      'text1': 'Descrição Cálcio',
      'text2': 'Outra informação sobre ',
      'text3': 'teste',
      'text4': '',
      'min': '2.0',
      'max': '7.0',
    },
    {
      'subclass': 'Inflamação Neurogênica',
      'text1': 'Descrição Inflamação Neuro',
      'text2': 'Outra informação sobre ',
      'text3': 'teste',
      'text4': '',
      'min': '3.0',
      'max': '9.0',
    },
  ];

  Map<String, int> subclassIndexMap = {
    'C.ACNESS': 0,
    'DHT': 1,
    'Antisséptico': 2,
    'Bactericida': 3,
    'AQP-3': 4,
    'Cálcio': 5,
    'Corticoide-Like': 6,
    'Inflamação Neurogênica': 7,
  };

  void showInfoDialog(BuildContext context, String medication) {
    int infoIndex = subclassIndexMap[medication]!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            medication,
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

  Map<String, String> vehicleSubtitles = {
    'Veiculo 1': 'Subtitulo para veiculo 1',
    'Veiculo 2': 'Subtitulo para veiculo 2',
    'Veiculo 3': 'Subtitulo para veiculo 3',
    'Veiculo 4': 'Subtitulo para veiculo 4',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Image.asset('assets/logo.png', width: 150),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...widget.selectedVehicleMap.entries.map((entry) {

                    String medication = entry.key;
                    List<String> vehicles = entry.value;

                    if (vehicles.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 145,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: douradoEscuro,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      vehicles.join(', '),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _showVehicleInfoDialog(context, vehicles);
                                      },
                                      child: const Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    vehicleSubtitles[vehicles[0]] ?? '',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      observacoesVeiculos[vehicles[0]] = value; 
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Observação...',
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: dourado,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2, color: dourado),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }).toList(),
                  for (int i = 0; i < widget.selectedActives.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: dourado,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    getCustomTitle(widget.selectedActives[i]),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: douradoEscuro,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showInfoDialog(context, widget.selectedActives[i]);
                                    },
                                    icon: Icon(
                                      Icons.info_outline,
                                      color: douradoEscuro,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                getShortDescription(infoList[subclassIndexMap[widget.selectedActives[i]]!]['text1']!, 30),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  color: douradoEscuro,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'MIN ${infoList[subclassIndexMap[widget.selectedActives[i]]!]['min']!}%',
                                    style: GoogleFonts.poppins(color: douradoEscuro, fontSize: 14),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: SizedBox(
                                      width: 150,
                                      child: TextFormField(
                                        controller: _controllers[i],
                                        onChanged: (value) {
                                          currentIndex = i;
                                          _validateInput(value, i);
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Colors.grey[300],
                                          focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'MAX ${infoList[subclassIndexMap[widget.selectedActives[i]]!]['max']!}%',
                                    style: GoogleFonts.poppins(color: douradoEscuro),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  errorMessages[i],
                                  style: GoogleFonts.poppins(color: Colors.red),
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfPage(
                      periodo: widget.periodo,
                      nomeCompleto: widget.nomeCompleto,
                      descricao: widget.descricao,
                      isGestante: widget.isGestante,
                      selectedActives: widget.selectedActives,
                      valoresDosCampos: valoresDosCampos,
                      selectedVehicles: widget.selectedVehicleMap.values.expand((vehicles) => vehicles).toList(),
                      observacoesVeiculos: observacoesVeiculos,
                    ),
                  ),
                );
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
                        'GERAR PDF',
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
    );
  }
}
