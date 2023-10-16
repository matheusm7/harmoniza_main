import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user; // Armazena o usuário autenticado

  String _nomeCompleto = '';
  final Map<String, Map<String, dynamic>> _pacientes = {};

  // Construtor que inicializa o usuário autenticado
  AppState() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;

  String get nomeCompleto => _nomeCompleto;

  Map<String, Map<String, dynamic>> get pacientes => _pacientes;

  // Método para atualizar os dados do paciente
  void atualizarPaciente(String pacienteId, Map<String, dynamic> pacienteData) {
    if (_pacientes.containsKey(pacienteId)) {

      _pacientes[pacienteId] = pacienteData;
    } else {
      _pacientes[pacienteId] = pacienteData;
    }
    notifyListeners();
  }

  // Método para adicionar um novo paciente à lista
  void adicionarPaciente(String pacienteId, Map<String, dynamic> pacienteData) {
    _pacientes[pacienteId] = pacienteData;
    notifyListeners();
  }

  Future<void> salvarDadosPaciente(String pacienteId, Map<String, dynamic> pacienteData) async {
    try {
      final userId = _user?.uid;
      if (userId != null) {

        await _firestore.collection('usuarios').doc(userId).collection('pacientes').doc(pacienteId).set(pacienteData);
      }
    } catch (error) {
      print('Erro ao salvar dados do paciente: $error');
      rethrow;
    }
  }

  void setNomeCompleto(String nome) {
    _nomeCompleto = nome;
    notifyListeners();
  }
}
