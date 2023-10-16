import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harmoniza_ativos/app/pages/consultation/pdf%20page/util/patient_data.dart';
import 'package:harmoniza_ativos/app/pages/consultation/pdf%20page/util/util.dart';
import 'package:harmoniza_ativos/app/pages/main_page.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class PdfPage extends StatefulWidget {
  final String nomeCompleto;
  final String descricao;
  final bool isGestante;
  final String periodo;
  final List<String> selectedActives;
  final List<String> valoresDosCampos;
  final List<String> selectedVehicles;
  final Map<String, String> observacoesVeiculos;

  const PdfPage({
    Key? key,
    required this.nomeCompleto,
    required this.descricao,
    required this.isGestante,
    required this.periodo,
    required this.selectedActives,
    required this.valoresDosCampos,
    required this.selectedVehicles,
    required this.observacoesVeiculos,
  }) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  PrintingInfo? printingInfo;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (kIsWeb)
        const PdfPreviewAction(
          icon: Icon(Icons.save),
          onPressed: saveAsFile,
        ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Flutter PDF'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              final patientData = Provider.of<PatientData>(context, listen: false);

              patientData.addConsultation(
                PatientInfo(
                  nomeCompleto: widget.nomeCompleto,
                  descricao: widget.descricao,
                  periodo: widget.periodo,
                  selectedActives: widget.selectedActives,
                ),
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
            },
            child: const Text(
              'Salvar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        actions: actions,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: (format) async {
          return pdfbody(
            format,
            widget.nomeCompleto,
            widget.descricao,
            widget.isGestante,
            widget.periodo,
            widget.selectedActives,
            widget.valoresDosCampos,
            widget.selectedVehicles,
            widget.observacoesVeiculos,
          );
        },
      ),
    );
  }
}
