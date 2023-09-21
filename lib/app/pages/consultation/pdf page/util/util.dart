import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'my_category.dart';

Future<Uint8List> generatePdf(
  final PdfPageFormat format,
  String nomePaciente,
  String descricao,
  bool isGestante,
  String periodo,
  List<String> selectedActives,
  List<String> valoresDosCampos,
  String selectedVehicle,
  String observacao,
) async {
  String displayName = '';
  final doc = pw.Document(
    title: 'Pdf',
  );
  final logoImage = pw.MemoryImage(
    (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
  );

  final pageTheme = await _myPageTheme(format);

  Map<String, String> subclassToCustomName = {
    'C.ACNESS': 'Acne less',
    'DHT': 'Acnebiol',
    'Antisséptico': 'Indufence',
    'Bactericida': 'Nano drieline',
    'AQP-3': 'Modukine',
    'Cálcio': 'Madecassoside',
    'Corticoide-Like': 'Ácido salicílico',
    'Inflamação Neurogênica': 'Betapur',
  };

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (final context) {
        final List<pw.Widget> widgets = [];

        widgets.add(
          pw.Container(
            padding: const pw.EdgeInsets.only(left: 30, bottom: 20, top: 20, right: 30),
            child: pw.Column(
              children: [
                pw.Image(logoImage, width: 130, height: 130),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.SizedBox(height: 5),
                pw.Column(
                  children: [
                    pw.Text(
                      'Dados da consulta',
                      style: pw.TextStyle(
                        fontSize: 25,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Row(
                        children: [
                          MyCategory('Profissional:'),
                          pw.Text(
                            FirebaseAuth.instance.currentUser?.displayName ?? displayName,
                            style: const pw.TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Row(
                        children: [
                          MyCategory('Data da consulta:'),
                          pw.Text(
                            '02/03/2023 ',
                            style: const pw.TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Row(
                        children: [
                          MyCategory('Período:'),
                          pw.Text(
                            periodo,
                            style: const pw.TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Row(
                        children: [
                          MyCategory('Grávida:'),
                          pw.Text(isGestante ? 'Sim' : 'Não', style: const pw.TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    pw.Divider(),
                    pw.Text(
                      'Dados do paciente',
                      style: pw.TextStyle(
                        fontSize: 25,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Row(
                        children: [
                          MyCategory('Paciente:'),
                          pw.Text(
                            nomePaciente,
                            style: const pw.TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Row(
                        children: [
                          MyCategory('Descrição:'),
                          pw.Container(
                            width: 390,
                            child: pw.RichText(
                              text: pw.TextSpan(
                                text: descricao,
                                style: const pw.TextStyle(
                                  fontSize: 20,
                                  color: PdfColors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Divider(),
                    // Adicione um loop para criar um widget para cada par de medicação e texto
                    for (var i = 0; i < selectedActives.length; i++)
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            subclassToCustomName[selectedActives[i]] ?? selectedActives[i],
                            style: const pw.TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                'Concentração: ',
                                style: const pw.TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              pw.Text(
                                valoresDosCampos[i], // Usar o valor da lista
                                style: const pw.TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              pw.Text(
                                '%', // Usar o valor da lista
                                style: const pw.TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    pw.SizedBox(
                      height: 90,
                    ),
                    pw.Row(children: [
                      pw.Text(
                        '$selectedVehicle:', // Concatenar as duas strings aqui
                        style: const pw.TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      pw.SizedBox(width: 5),
                      pw.Text(observacao, style: const pw.TextStyle(fontSize: 20)),
                    ])
                  ],
                ),
              ],
            ),
          ),
        );

        return widgets;
      },
    ),
  );

  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  return pw.PageTheme(
    margin: const pw.EdgeInsets.symmetric(horizontal: 1 * PdfPageFormat.cm, vertical: 0.5 * PdfPageFormat.cm),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
    buildBackground: (final context) => pw.FullPage(
      ignoreMargins: true,
    ),
  );
}

Future<void> saveAsFile(
  final BuildContext context,
  final LayoutCallback build,
  final PdfPageFormat pageFormat,
) async {
  final bytes = await build(pageFormat);
  final appDocPath = await getApplicationDocumentsDirectory();
  final file = File('$appDocPath/document.pdf');
  print('save as file ${file.path}...');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Document printed sucessfully')));
}

void showSharedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Document shared sucessfully')));
}
