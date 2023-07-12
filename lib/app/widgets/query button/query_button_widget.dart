import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../pages/consultation/query_definition_page.dart';

class QueryButton extends StatefulWidget {
  final String title;
  final IconData icon;
  const QueryButton({super.key, required this.title, required this.icon});

  @override
  State<QueryButton> createState() => _QueryButtonState();
}

class _QueryButtonState extends State<QueryButton> {
  Color dourado = const Color.fromARGB(255, 143, 121, 76);
  Color backgroundColor = const Color.fromARGB(255, 225, 216, 195);

  String nomeCompleto = '';
  String descricao = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          openDialog();
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

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancelar',
                style: GoogleFonts.poppins(color: dourado, fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              onPressed: () {
                if (nomeCompleto.isEmpty || descricao.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Erro',
                        style: TextStyle(color: dourado),
                      ),
                      content: const Text('Por favor, preencha todos os campos.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(color: dourado),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QueryDefinition()),
                  );
                }
              },
              child: Text(
                'Salvar',
                style: GoogleFonts.poppins(color: dourado, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          backgroundColor: Colors.grey[300],
          title: Text(
            'Cadastro do paciente',
            style: TextStyle(color: dourado),
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
                  fillColor: backgroundColor,
                  hintText: 'Nome completo',
                  border: const OutlineInputBorder(),
                  hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: dourado),
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
                  fillColor: backgroundColor,
                  hintText: 'Descrição',
                  hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: dourado),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
