import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/data/data.dart';
import 'package:harmoniza_ativos/app/pages/consultation/pdf%20page/util/patient_data.dart';
import 'package:provider/provider.dart';

import '../../../../controller/app state/app_state.dart';

class HistoricConsultationPage extends StatefulWidget {
  const HistoricConsultationPage({Key? key}) : super(key: key);

  @override
  State<HistoricConsultationPage> createState() => _HistoricConsultationPageState();
}

class _HistoricConsultationPageState extends State<HistoricConsultationPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final patientData = Provider.of<PatientData>(context);
    final historicConsultations = patientData.historicConsultations;
    final User? user = auth.currentUser;
    final appState = Provider.of<AppState>(context);
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Você não está autenticado. Faça o login para acessar o histórico de consultas'),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: douradoEscuro,
                          ),
                        ),
                      )
                    ],
                  ),
                  Image.asset(
                    'assets/logo.png',
                    width: 150,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'HISTORICO DE CONSULTAS',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: douradoEscuro,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: historicConsultations.length,
                    itemBuilder: (context, index) {
                      final consulta = historicConsultations[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(consulta.nomeCompleto),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nome: ${consulta.nomeCompleto}'),
                              Text('Descrição: ${consulta.descricao}'),
                              Text('Período: ${consulta.periodo}'),
                              Text('Ativos: ${consulta.selectedActives.map((active) => getCustomTitle(active)).join(', ')}'),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
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
