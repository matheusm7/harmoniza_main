import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/pages/consultation/diagnostic/diagnostic_page.dart';

import '../../../data/data.dart';

class QueryDefinition extends StatefulWidget {
  final String nomePaciente;
  final String nomeCompleto;
  final String descricao;
  final bool isGestante;
  final String periodo;
  const QueryDefinition({Key? key, required this.descricao, required this.nomeCompleto, required this.isGestante, required this.periodo, required this.nomePaciente}) : super(key: key);

  @override
  State<QueryDefinition> createState() => _QueryDefinitionState();
}

class _QueryDefinitionState extends State<QueryDefinition> {
  String nomeCompleto = '';
  String descricao = '';
  bool switchValue = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  String? selectedValue = 'Diurno';

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
                'DEFINIÇÕES DA CONSULTA',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: douradoEscuro,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'A paciente é gestante?',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Column(
                      children: [
                        Switch(
                          activeColor: douradoEscuro,
                          value: switchValue,
                          onChanged: (newValue) {
                            setState(() {
                              switchValue = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Buscar somente produtos veganos',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Column(
                      children: [
                        Switch(
                          activeColor: douradoEscuro,
                          value: switchValue2,
                          onChanged: (newValue2) {
                            setState(() {
                              switchValue2 = newValue2;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Buscar somente produtos orgânicos?',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Column(
                      children: [
                        Switch(
                          activeColor: douradoEscuro,
                          value: switchValue3,
                          onChanged: (newValue3) {
                            setState(() {
                              switchValue3 = newValue3;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<String?>(
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  hint: const Text('Diurno'),
                  underline: const SizedBox(),
                  isExpanded: true,
                  items: [
                    "Diurno",
                    "Noturno",
                    "Ambos",
                  ]
                      .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiagnosticPage(
                          descricao: widget.descricao,
                          nomeCompleto: widget.nomeCompleto,
                          isGestante: switchValue,
                          periodo: selectedValue ?? 'Diurno',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: douradoEscuro),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: douradoEscuro),
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
                        ),
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
