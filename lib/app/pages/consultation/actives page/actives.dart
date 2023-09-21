import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/pages/consultation/vehicle/vehicle_page.dart';

import '../../../data/data.dart';

class ActivesPage extends StatefulWidget {
  final String nomeCompleto;
  final String descricao;
  final List<String> subclasses;
  final List<String> classNames;
  final List<String> selectedMedications;
  final bool isPorDiagnosticoSelected;
  final Map<String, List<String>> selectedVehicleMap;
  final bool isGestante;
  final String periodo;

  const ActivesPage({
    Key? key,
    required this.subclasses,
    required this.classNames,
    required this.selectedMedications,
    required this.isPorDiagnosticoSelected,
    required this.selectedVehicleMap,
    required this.descricao,
    required this.nomeCompleto,
    required this.isGestante,
    required this.periodo,
  }) : super(key: key);

  @override
  State<ActivesPage> createState() => _ActivesPageState();
}

String getCustomTitle(String subclass) {
  switch (subclass) {
    case 'C.ACNESS':
      return 'Acne less';
    case 'DHT':
      return 'Acnebiol';
    case 'Antisséptico':
      return 'Indufence';
    case 'Bactericida':
      return 'Nano drieline';
    case 'AQP-3':
      return 'Modukine';
    case 'Cálcio':
      return 'Madecassoside';
    case 'Corticoide-Like':
      return 'Ácido salicílico';
    case 'Inflamação Neurogênica':
      return 'Betapur';
    default:
      return '';
  }
}

class _ActivesPageState extends State<ActivesPage> {
  String nomeCompleto = '';
  String descricao = '';
  bool switchValue = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  String? selectedValue = 'Diurno';
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  Color douradoEscuro = const Color.fromARGB(255, 168, 138, 78);
  List<bool> _isCheckedList = [];

  List<Map<String, String>> infoList = [
    {
      'subclass': 'Acne less',
      'text1': 'Mecanismo de ação: ',
      'text2': 'Acne Less é um tratamento revolucionário para acne que promove a redução efetiva da inflamação e eliminação das espinhas. Sua fórmula avançada combate as causas da acne, regulando a produção de sebo e desobstruindo os poros, proporcionando uma pele mais saudável e livre de imperfeições. Com resultados visíveis em poucas semanas, Acne Less é a solução ideal para quem busca uma pele limpa e sem acne.',
      'text3': '5.0 - 7.0',
      'text4': '0.5 a 7',
    },
    {
      'subclass': 'Acnebiol',
      'text1': 'Acnebiol é um medicamento utilizado no tratamento da acne, que age diminuindo a produção de sebo e combatendo a inflamação da pele. Sua fórmula inclui substâncias como o ácido salicílico e o peróxido de benzoíla, que ajudam a reduzir a formação de cravos e espinhas, proporcionando uma pele mais saudável e livre de acne.',
      'text2': 'Outra informação sobre DHT',
      'text3': '0.3 a 5.0',
      'text4': '',
    },
    {
      'subclass': 'Antisséptico',
      'text1': 'Um antisséptico é uma substância que interrompe ou retarda o crescimento de micro-organismos. Ele é usado com frequência ​​em hospitais e outros ambientes médicos para reduzir o risco de infecção durante a cirurgia e outros procedimentos.',
      'text2': 'Outra informação sobre ',
      'text3': 'teste',
      'text4': '',
    },
    {
      'subclass': 'Bactericida',
      'text1': 'Informação sobre ',
      'text2': 'Outra informação sobre',
      'text3': 'teste',
      'text4': '',
    },
    {
      'subclass': 'AQP-3',
      'text1': 'Informação sobre ',
      'text2': 'Outra informação sobre ',
      'text3': 'teste',
      'text4': '',
    },
    {
      'subclass': 'Cálcio',
      'text1': 'Informação sobre ',
      'text2': 'Outra informação sobre ',
      'text3': 'teste',
      'text4': '',
    },
    {
      'subclass': 'Corticoide-Like',
      'text1': 'Informação sobre ',
      'text2': 'Outra informação sobre ',
      'text3': 'teste',
      'text4': '',
    },
    {
      'subclass': 'Inflamação Neurogênica',
      'text1': 'Informação sobre ',
      'text2': 'Outra informação sobre ',
      'text3': 'teste',
      'text4': '',
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

  List<String> _getSelectedActives() {
    List<String> selectedActives = [];

    for (int i = 0; i < _isCheckedList.length; i++) {
      if (_isCheckedList[i]) {
        selectedActives.add(widget.subclasses[i]);
      }
    }

    return selectedActives;
  }

  @override
  void initState() {
    super.initState();
    _isCheckedList = List<bool>.filled(widget.subclasses.length, false);
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  void showInfoDialog(BuildContext context, int index) {
    String subclass = widget.subclasses[index];
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Image.asset('assets/logo.png', width: 150),
          const SizedBox(height: 20),
          Text(
            'ATIVOS',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: douradoEscuro,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (_currentPageIndex == 0)
                  Text(
                    'Ativos',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: douradoEscuro),
                  ),
                if (_currentPageIndex == 0)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: douradoEscuro,
                  )
              ],
            ),
          ),
          SizedBox(
            width: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_currentPageIndex == 1)
                  Icon(
                    Icons.arrow_back_ios,
                    size: 12,
                    color: douradoEscuro,
                  ),
                if (_currentPageIndex == 1)
                  Text(
                    'Favoritos',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: douradoEscuro),
                  ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(activesRow.length, (index) => buildDot(index, context)),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return buildActivesPage();
                } else if (index == 1) {
                  return FavoritesPage(
                    selectedSubclasses: widget.subclasses.where((subclass) => _isCheckedList[widget.subclasses.indexOf(subclass)]).toList(),
                    selectedClassNames: widget.classNames.where((className) => _isCheckedList[widget.classNames.indexOf(className)]).toList(),
                    onUncheck: (String subclass) {
                      setState(() {
                        int index = widget.subclasses.indexOf(subclass);
                        if (index != -1) {
                          _isCheckedList[index] = false;
                        }
                      });
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToIntermediatePage(List<String> selectedActives) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VehiclePage(
                selectedMedications: widget.selectedMedications,
                isPorDiagnosticoSelected: widget.isPorDiagnosticoSelected,
                selectedVehicleMap: widget.selectedVehicleMap,
                selectedActives: selectedActives,
                descricao: widget.descricao,
                nomeCompleto: widget.nomeCompleto,
                isGestante: widget.isGestante,
                periodo: widget.periodo,
              )),
    );
  }

  Widget buildActivesPage() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.subclasses.length,
                itemBuilder: (BuildContext context, int index) {
                  String subclass = widget.subclasses[index];
                  String customTitle = getCustomTitle(subclass);
                  return CheckboxListTile(
                    activeColor: douradoEscuro,
                    value: _isCheckedList[index],
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isCheckedList[index] = newValue ?? false;
                      });
                    },
                    title: Text(
                      customTitle,
                      style: TextStyle(fontWeight: FontWeight.bold, color: douradoEscuro),
                    ),
                    subtitle: Text(widget.classNames[index]),
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
                  _navigateToIntermediatePage(_getSelectedActives());
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

  AnimatedContainer buildDot(int index, BuildContext context) {
    String pageTitle = '';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 6,
      width: _currentPageIndex == index ? 24 : 6,
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentPageIndex == index ? const Color.fromARGB(255, 168, 138, 78) : const Color.fromARGB(255, 134, 125, 107),
      ),
      child: Visibility(
        visible: _currentPageIndex == index,
        child: Center(
          child: Text(
            pageTitle,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<String> selectedSubclasses;
  final List<String> selectedClassNames;
  final Function(String) onUncheck;

  const FavoritesPage({
    Key? key,
    required this.selectedSubclasses,
    required this.selectedClassNames,
    required this.onUncheck,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: selectedSubclasses.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index < selectedSubclasses.length && index < selectedClassNames.length) {
                    String subclass = selectedSubclasses[index];
                    String customTitle = getCustomTitle(subclass); // Pass 'subclass' to getCustomTitle
                    String className = selectedClassNames[index];

                    return CheckboxListTile(
                      activeColor: douradoEscuro,
                      value: true,
                      onChanged: (bool? newValue) {
                        if (newValue == false) {
                          onUncheck(subclass);
                        }
                      },
                      title: Text(
                        customTitle,
                        style: TextStyle(fontWeight: FontWeight.bold, color: douradoEscuro),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      subtitle: Text(className),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
