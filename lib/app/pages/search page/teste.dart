import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/app state/app_state.dart';
import '../../data/data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Você não está autenticado.'),
        ),
      );
    }

    final appState = Provider.of<AppState>(context);

    final pacientes = appState.pacientes.values.where((paciente) => paciente['userId'] == user.uid).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 250,
            color: dourado,
          ),
          Column(
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
                onChanged: (value) {
                  setState(() {
                    searchTerm = value.toLowerCase();
                  });
                },
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
              if (pacientes.isNotEmpty)
                Column(
                  children: pacientes.map((paciente) {
                    return ListTile(
                      title: Text('Paciente: ${paciente['nome']}'),
                      subtitle: Text('${paciente['descricao']}'),
                    );
                  }).toList(),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
