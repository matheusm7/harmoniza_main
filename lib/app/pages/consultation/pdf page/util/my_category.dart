import 'package:pdf/widgets.dart' as pw;

class MyCategory extends pw.StatelessWidget {
  final String title;

  MyCategory(this.title);

  @override
  pw.Widget build(pw.Context context) => pw.Container(
      decoration: const pw.BoxDecoration(
        borderRadius: pw.BorderRadius.all(
          pw.Radius.circular(6),
        ),
      ),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(title, textScaleFactor: 1.5, style: const pw.TextStyle(fontSize: 13)));
}
