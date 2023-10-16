import 'package:flutter/material.dart';

class HistoricConsultationState extends ChangeNotifier {
  String nomeCompleto = '';
  String descricao = '';
  bool isGestante = false;
  String periodo = '';
  List<String> selectedActives = [];

  void setHistoricConsultationInfo({
    required String nomeCompleto,
    required String descricao,
    required bool isGestante,
    required String periodo,
    required List<String> selectedActives,
  }) {
    this.nomeCompleto = nomeCompleto;
    this.descricao = descricao;
    this.isGestante = isGestante;
    this.periodo = periodo;
    this.selectedActives = selectedActives;


    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }
}
