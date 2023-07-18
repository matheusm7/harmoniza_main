import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivesPage extends StatefulWidget {
  final List<String> subclasses;
  final List<String> classNames;

  const ActivesPage({Key? key, required this.subclasses, required this.classNames}) : super(key: key);

  @override
  State<ActivesPage> createState() => _ActivesPageState();
}

class _ActivesPageState extends State<ActivesPage> {
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
      'text3': 'teste',
      'text4': '',
    },
    {
      'subclass': 'Antisséptico',
      'text1': 'Informação sobre Nike',
      'text2': 'Outra informação sobre Nike',
      'text3': 'teste',
      'text4': '',
    },
    {
      'subclass': 'Bactericida',
      'text1': 'Informação sobre Adidas',
      'text2': 'Outra informação sobre Adidas',
      'text3': 'teste',
      'text4': '',
    },
    {
      'subclass': 'AQP-3',
      'text1': 'Informação sobre Arroz',
      'text2': 'Outra informação sobre Arroz',
      'text3': 'teste',
      'text4': '',
    },
    {
      'subclass': 'Cálcio',
      'text1': 'Informação sobre Feijão',
      'text2': 'Outra informação sobre Feijão',
      'text3': 'teste',
      'text4': '',
    },
    {
      'subclass': 'Corticoide-Like',
      'text1': 'Informação sobre Energetico',
      'text2': 'Outra informação sobre Energetico',
      'text3': 'teste',
      'text4': '',
    },
    {
      'subclass': 'Inflamação Neurogênica',
      'text1': 'Informação sobre Vinho',
      'text2': 'Outra informação sobre Vinho',
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

  @override
  void initState() {
    super.initState();
    _isCheckedList = List<bool>.filled(widget.subclasses.length, false);
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
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset('assets/logo.png', width: 150),
            const SizedBox(height: 50),
            Text(
              'ATIVOS',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: douradoEscuro,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
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
          ],
        ),
      ),
    );
  }
}
