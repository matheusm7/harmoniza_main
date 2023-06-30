import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QueryDefinition extends StatefulWidget {
  const QueryDefinition({super.key});

  @override
  State<QueryDefinition> createState() => _QueryDefinitionState();
}

class _QueryDefinitionState extends State<QueryDefinition> {
  bool switchValue = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  String? selectedValue;

  Color dourado = const Color.fromARGB(255, 168, 138, 78);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/logo.png',
                  width: 150,
                ),
                const SizedBox(height: 50),
                Text(
                  'DEFINIÇÕES DA CONSULTA',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: dourado,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
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
                            activeColor: dourado,
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
                            activeColor: dourado,
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
                            activeColor: dourado,
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
                    hint: const Text('DIURNO'),
                    underline: const SizedBox(),
                    isExpanded: true,
                    items: [
                      "DIURNO",
                      "NOTURNO",
                      "AMBOS",
                    ]
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 120),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/assetClasses');
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: dourado),
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
                      Navigator.pushNamed(context, '/mainPage');
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: dourado),
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
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
