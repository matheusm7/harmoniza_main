import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    if (user == null) {
      // Usuário não autenticado, lidar com isso adequadamente
      return const Scaffold(
        body: Center(
          child: Text('Você não está autenticado.'),
        ),
      );
    }

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _firestore.collection('pacientes').doc(user.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao buscar dados do paciente: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final pacienteData = snapshot.data!.data();
          if (pacienteData == null) {
            return const Center(
              child: Text('Nenhum paciente encontrado para este usuário.'),
            );
          }

          // Construa sua interface do usuário com base nos dados do paciente.
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    'assets/logo.png',
                    width: 130,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Procure por um Paciente",
                          style: TextStyle(
                            color: douradoEscuro,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: douradoEscuro,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Digite...",
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            prefixIcon: const Icon(Icons.search),
                            prefixIconColor: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        // Aqui você pode exibir os dados do paciente
                        Text('Nome do Paciente: ${pacienteData['nome']}'),
                        Text('Descrição do Paciente: ${pacienteData['descricao']}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text('Nenhum paciente encontrado para este usuário.'),
          );
        }
      },
    );
  }
}
