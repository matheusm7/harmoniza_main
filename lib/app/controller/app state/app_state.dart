import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  List<Map<String, String>> pacientes = [];

  Future<void> salvarDadosPaciente(String userId, Map<String, dynamic> pacienteData) async {
    try {
      await FirebaseFirestore.instance.collection('pacientes').doc(userId).set(pacienteData);
    } catch (error) {
      // ignore: avoid_print
      print('Erro ao salvar dados do paciente: $error');
      rethrow;
    }
  }
}
