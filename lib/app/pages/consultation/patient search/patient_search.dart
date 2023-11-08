import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/controller/app%20state/app_state.dart';
import 'package:harmoniza_ativos/app/data/data.dart';
import 'package:harmoniza_ativos/app/pages/consultation/query%20definition/query_definition_page.dart';
import 'package:provider/provider.dart';

import '../../../widgets/query button/query_button_widget.dart';

class PatientSearch extends StatefulWidget {
  final String nomePaciente;
  final String descricao;
  final bool isGestante;
  final String periodo;
  const PatientSearch({Key? key, required this.descricao, required this.isGestante, required this.nomePaciente, required this.periodo}) : super(key: key);

  @override
  State<PatientSearch> createState() => PatientSearchState();
}

class PatientSearchState extends State<PatientSearch> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? selectedValue;
  List<String> dropdownItems = [];
  String searchTerm = '';
  String selectedLetter = '';
  String selectedPatientId = '';
  String selectedPatientName = '';
  String descricao = '';
  String descricaoDoPacienteSelecionado = '';

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Você não está autenticado.'),
        ),
      );
    }

    void _showErrorDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text('Por favor, selecione um paciente ou cadastre para iniciar a consulta'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: douradoEscuro),
                ),
              ),
            ],
          );
        },
      );
    }

    final appState = Provider.of<AppState>(context);
    final pacientes = appState.pacientes.values
        .where(
          (paciente) => paciente['userId'] == user.uid && paciente['nome'].toLowerCase().contains(searchTerm.toLowerCase()) && (selectedLetter.isEmpty || paciente['nome'].toLowerCase().startsWith(selectedLetter.toLowerCase())),
        )
        .toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: douradoEscuro,
                    ),
                  ),
                ),
              ],
            ),
            Image.asset(
              'assets/logo.png',
              width: 150,
            ),
            const SizedBox(height: 20),
            Text(
              'BUSCA DE PACIENTES',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: douradoEscuro),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    selectedLetter = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  hintText: 'Digite...',
                  border: const OutlineInputBorder(),
                  hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: dourado),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  children: pacientes.map((paciente) {
                    final pacienteId = paciente['pacienteId'];
                    final isSelected = pacienteId == selectedPatientId;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPatientId = isSelected ? '' : pacienteId;
                          selectedPatientName = isSelected ? '' : paciente['nome'];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(color: isSelected ? dourado : Colors.transparent, borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text(
                            '${paciente['nome']}',
                            style: GoogleFonts.poppins(color: isSelected ? Colors.black : Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  const queryButton = QueryButton(title: 'Cadastrar Paciente', icon: Icons.add);
                  queryButton.openDialog(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: douradoEscuro,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: const Center(
                    child: Text(
                      'CADASTRAR PACIENTE',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  if (selectedPatientId.isEmpty) {
                    _showErrorDialog();
                  } else {
                    final pacienteSelecionado = appState.pacientes[selectedPatientId];

                    if (pacienteSelecionado != null) {
                      descricaoDoPacienteSelecionado = pacienteSelecionado['descricao'];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QueryDefinition(
                            nomeCompleto: selectedPatientName,
                            descricao: descricaoDoPacienteSelecionado,
                            isGestante: false,
                            periodo: '',
                            nomePaciente: selectedPatientName,
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
                  child: const Center(
                    child: Text(
                      'INICIAR CONSULTA',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
