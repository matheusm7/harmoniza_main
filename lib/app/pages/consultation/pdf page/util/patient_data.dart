import 'package:flutter/material.dart';

class PatientData extends ChangeNotifier {
  List<PatientInfo> historicConsultations = [];

  void addConsultation(PatientInfo info) {
    historicConsultations.add(info);
    notifyListeners();
  }
}

class PatientInfo {
  final String nomeCompleto;
  final String descricao;
  final String periodo;
  final List<String> selectedActives;

  PatientInfo({
    required this.nomeCompleto,
    required this.descricao,
    required this.periodo,
    required this.selectedActives,
  });
}
