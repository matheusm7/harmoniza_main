import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consultation/vehicle/historic.dart';

class HistoricConsultation extends StatelessWidget {
  const HistoricConsultation({super.key});

  @override
  Widget build(BuildContext context) {
    final historicConsultationState = Provider.of<HistoricConsultationState>(context);


    final List<String> selectedActives = historicConsultationState.selectedActives;

    final List<String> customTitles = selectedActives.map((subclass) {
      return getCustomTitle(subclass);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Consulta'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              historicConsultationState.nomeCompleto,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            title: Text(
              'Descrição: ${historicConsultationState.descricao}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            title: Text(
              'Gestante: ${historicConsultationState.isGestante ? 'Sim' : 'Não'}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            title: Text(
              'Periodo: ${historicConsultationState.periodo}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 20), 
          ListView.builder(
            shrinkWrap: true,
            itemCount: customTitles.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  'Título Personalizado: ${customTitles[index]}',
                  style: const TextStyle(fontSize: 20),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

String getCustomTitle(String subclass) {
  switch (subclass) {
    case 'C.ACNESS':
      return 'Acne less';
    case 'DHT':
      return 'Acnebiol';
    case 'Antisséptico':
      return 'Indufence';
    case 'Bactericida':
      return 'Nano drieline';
    case 'AQP-3':
      return 'Modukine';
    case 'Cálcio':
      return 'Madecassoside';
    case 'Corticoide-Like':
      return 'Ácido salicílico';
    case 'Inflamação Neurogênica':
      return 'Betapur';
    default:
      return '';
  }
}
