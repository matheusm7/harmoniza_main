import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/data/data.dart';
import 'package:harmoniza_ativos/app/pages/consultation/vehicle/historic.dart';
import 'package:provider/provider.dart';

class HistoricConsultation extends StatelessWidget {
  const HistoricConsultation({super.key});

  @override
  Widget build(BuildContext context) {
    final historicConsultationState = Provider.of<HistoricConsultationState>(context);
    final userUID = FirebaseAuth.instance.currentUser?.uid;

    if (userUID != null && historicConsultationState.historicData.containsKey(userUID)) {
      final List<HistoricData> userHistoricData = historicConsultationState.historicData[userUID]!;

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    ),
                  ],
                ),
                Image.asset(
                  'assets/logo.png',
                  width: 150,
                ),
                const SizedBox(height: 30),
                Text(
                  'HISTÓRICO DE CONSULTAS',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: douradoEscuro,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: userHistoricData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final historicData = userHistoricData[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(
                            historicData.nomeCompleto,
                            style: const TextStyle(fontSize: 17),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Descrição: ${historicData.descricao}'),
                              Text('Gestante: ${historicData.isGestante ? 'Sim' : 'Não'}'),
                              Text('Período: ${historicData.periodo}'),
                              Text(
                                historicData.selectedActives.join(', '),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Column(
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
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/logo.png',
                      width: 150,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'HISTÓRICO DE CONSULTAS',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: douradoEscuro,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Center(
                              child: Text(
                                "Nenhuma informação de paciente encontrada.",
                                style: GoogleFonts.poppins(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
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
