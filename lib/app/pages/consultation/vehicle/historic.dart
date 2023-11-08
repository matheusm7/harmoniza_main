import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoricConsultationState extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, List<HistoricData>> historicData = {};
  HistoricConsultationState() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        loadHistoricDataForCurrentUser(user.uid);
      } else {
        historicData.clear();
        notifyListeners();
      }
    });
  }

  Future<void> loadHistoricDataForCurrentUser(String userId) async {
    try {
      final querySnapshot = await _firestore.collection('historic').doc(userId).collection('consultations').get();
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final historicList = (data['consultations'] as List<dynamic>).map((entry) {
          return HistoricData(
            nomeCompleto: entry['nomeCompleto'],
            descricao: entry['descricao'],
            isGestante: entry['isGestante'],
            periodo: entry['periodo'],
            selectedActives: List<String>.from(entry['selectedActives']),
          );
        }).toList();
        historicData[userId] = historicList;
      }
      notifyListeners();
    } catch (error) {
      print('Erro ao carregar histórico de consultas: $error');
    }
  }

  // Método para salvar o histórico no Firebase Firestore
  Future<void> saveHistoricData(String userId, List<HistoricData> data) async {
    try {
      await _firestore.collection('historic').doc(userId).collection('consultations').doc('data').set({
        'consultations': data.map((entry) {
          return {
            'nomeCompleto': entry.nomeCompleto,
            'descricao': entry.descricao,
            'isGestante': entry.isGestante,
            'periodo': entry.periodo,
            'selectedActives': entry.selectedActives,
          };
        }).toList()
      });
    } catch (error) {
      print('Erro ao salvar histórico de consultas: $error');
    }
  }

  void setHistoricConsultationInfo({
    required String userUID,
    required String nomeCompleto,
    required String descricao,
    required bool isGestante,
    required String periodo,
    required List<String> selectedActives,
  }) {
    if (historicData.containsKey(userUID)) {
      bool isConsultationSaved = false;

      for (var historicEntry in historicData[userUID]!) {
        if (historicEntry.nomeCompleto == nomeCompleto && historicEntry.descricao == descricao && historicEntry.isGestante == isGestante && historicEntry.periodo == periodo && const ListEquality().equals(historicEntry.selectedActives, selectedActives)) {
          isConsultationSaved = true;
          break;
        }
      }

      if (!isConsultationSaved) {
        historicData[userUID]!.add(HistoricData(
          nomeCompleto: nomeCompleto,
          descricao: descricao,
          isGestante: isGestante,
          periodo: periodo,
          selectedActives: selectedActives,
        ));
      }
    } else {
      historicData[userUID] = [
        HistoricData(
          nomeCompleto: nomeCompleto,
          descricao: descricao,
          isGestante: isGestante,
          periodo: periodo,
          selectedActives: selectedActives,
        )
      ];
    }

    saveHistoricData(userUID, historicData[userUID]!);

    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }
}

class HistoricData {
  String nomeCompleto = '';
  String descricao = '';
  bool isGestante = false;
  String periodo = '';
  List<String> selectedActives = [];

  HistoricData({
    required this.nomeCompleto,
    required this.descricao,
    required this.isGestante,
    required this.periodo,
    required this.selectedActives,
  });
}
