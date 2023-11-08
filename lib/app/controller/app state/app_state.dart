import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  String _nomeCompleto = '';
  final Map<String, Map<String, dynamic>> _pacientes = {};

  Future<void> init() async {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      if (_user != null) {
        _loadPacientesFromFirebase();
      }
      notifyListeners();
    });
  }

  User? get user => _user;
  String get nomeCompleto => _nomeCompleto;
  Map<String, Map<String, dynamic>> get pacientes => _pacientes;

  Future<void> _loadPacientesFromFirebase() async {
    try {
      final userId = _user!.uid;
      final querySnapshot = await _firestore.collection('usuarios').doc(userId).collection('pacientes').get();
      for (var doc in querySnapshot.docs) {
        _pacientes[doc.id] = doc.data();
      }
      notifyListeners();
    } catch (error) {
      print('Erro ao carregar pacientes do Firebase: $error');
    }
  }

  void atualizarPaciente(String pacienteId, Map<String, dynamic> pacienteData) {
    _pacientes[pacienteId] = pacienteData;
    salvarDadosPaciente(pacienteId, pacienteData); // Salva os dados do paciente no Firebase
    notifyListeners();
  }

  void adicionarPaciente(String pacienteId, Map<String, dynamic> pacienteData) {
    _pacientes[pacienteId] = pacienteData;
    salvarDadosPaciente(pacienteId, pacienteData); // Salva os dados do paciente no Firebase
    notifyListeners();
  }

  void setPacientes(Map<String, Map<String, dynamic>> pacientes) {
    _pacientes.clear();
    _pacientes.addAll(pacientes);
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
