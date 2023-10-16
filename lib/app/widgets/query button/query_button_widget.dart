import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/pages/consultation/patient%20search/patient_search.dart';
import 'package:harmoniza_ativos/app/pages/consultation/query%20definition/query_definition_page.dart';
import 'package:provider/provider.dart';

import '../../controller/app state/app_state.dart';
import '../../controller/auth controller/auth_controller.dart';
import '../../data/data.dart';

class QueryButton extends StatefulWidget {
  final String title;
  final IconData icon;
  const QueryButton({super.key, required this.title, required this.icon});

  Future openDialog(BuildContext context) async {
    final authProvider = Provider.of<AuthController>(context, listen: false);
    final appState = Provider.of<AppState>(context, listen: false);

    String nomeCompleto = '';
    String descricao = '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: GoogleFonts.poppins(color: douradoEscuro, fontWeight: FontWeight.bold),
            ),
          ),
          MaterialButton(
            onPressed: () async {
              if (nomeCompleto.isEmpty || descricao.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Erro',
                      style: TextStyle(color: dourado),
                    ),
                    content: const Text('Por favor, preencha todos os campos.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(color: dourado),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                final user = authProvider.user;
                if (user == null) {
                  return;
                }

           
                final pacienteId = DateTime.now().millisecondsSinceEpoch.toString();

                final pacienteData = {
                  'userId': user.uid,
                  'pacienteId': pacienteId,
                  'nome': nomeCompleto,
                  'descricao': descricao,
                };

                appState.adicionarPaciente(pacienteId, pacienteData);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QueryDefinition(
                      nomePaciente: nomeCompleto,
                      descricao: descricao,
                      nomeCompleto: nomeCompleto,
                      isGestante: false,
                      periodo: '',
                    ),
                  ),
                );
              }
            },
            child: Text(
              'Salvar',
              style: GoogleFonts.poppins(color: douradoEscuro, fontWeight: FontWeight.bold),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Cadastro do paciente',
          style: TextStyle(color: douradoEscuro),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  nomeCompleto = value;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  hintText: 'Nome completo',
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
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  descricao = value;
                },
                maxLines: 8,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  hintText: 'Descrição',
                  hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                  border: const OutlineInputBorder(),
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<QueryButton> createState() => QueryButtonState();
}

class QueryButtonState extends State<QueryButton> {
  Color backgroundColor = douradoEscuro;
  String nomeCompleto = '';
  String descricao = '';
  bool switchValue = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  String? selectedValue = 'Diurno';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientSearch(
                descricao: descricao,
                isGestante: false,
                nomePaciente: nomeCompleto,
                periodo: '',
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
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                widget.icon,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
