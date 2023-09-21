import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/app state/app_state.dart';
import '../../controller/auth controller/auth_controller.dart';
import '../../data/data.dart';
import '../../pages/consultation/query definition/query_definition_page.dart';

class QueryButton extends StatefulWidget {
  final String title;
  final IconData icon;
  // ignore: use_key_in_widget_constructors
  const QueryButton({Key? key, required this.title, required this.icon});

  @override
  State<QueryButton> createState() => _QueryButtonState();
}

class _QueryButtonState extends State<QueryButton> {
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
          openDialog(context); // Passe o contexto para openDialog
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

  Future openDialog(BuildContext context) async {
    // Adicione o contexto como argumento
    final authProvider = Provider.of<AuthController>(context, listen: false); // Obtenha o AuthProvider
    final appState = Provider.of<AppState>(context, listen: false);

    showDialog(
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
                  // Lida com o caso em que o usuário não está autenticado
                  return;
                }

                final pacienteData = {
                  'nome': nomeCompleto,
                  'descricao': descricao,
                };

                // Salva os dados do paciente no Firestore
                try {
                  await appState.salvarDadosPaciente(user.uid, pacienteData);
                } catch (error) {
                  // Trate erros aqui, se necessário
                  print('Erro ao salvar dados do paciente: $error');
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QueryDefinition(
                      periodo: 'Diurno',
                      isGestante: false,
                      descricao: descricao,
                      nomeCompleto: nomeCompleto,
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
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
    );
  }
}
