import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harmoniza_ativos/app/pages/consultation/pdf%20page/util/util.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPage extends StatefulWidget {
  final String nomePaciente;
  final String descricao;
  final bool isGestante;
  final String periodo;
  final List<String> selectedActives; // Adicione a lista de ativos selecionados
  final List<String> valoresDosCampos; // Adicione a lista de valoresDosCampos
  final String selectedVehicle;
  final String observacao;

  const PdfPage(
      {super.key,
      required this.nomePaciente,
      required this.descricao,
      required this.isGestante,
      required this.periodo,
      required this.selectedActives, // Passe a lista de ativos selecionados como parâmetro
      required this.valoresDosCampos, // Passe a lista de valoresDosCampos como parâmetro
      required this.selectedVehicle,
      required this.observacao});

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
        title: const Text('Flutter pdf'),
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        actions: actions,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: (format) async {
          return generatePdf(
            format,
            widget.nomePaciente,
            widget.descricao,
            widget.isGestante,
            widget.periodo,
            widget.selectedActives,
            widget.valoresDosCampos,
            widget.selectedVehicle,
            widget.observacao,
          );
        },
      ),
    );
  }
}
