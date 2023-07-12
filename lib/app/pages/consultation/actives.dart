import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivesPage extends StatefulWidget {
  final List<String> subclasses;

  const ActivesPage({Key? key, required this.subclasses}) : super(key: key);

  @override
  State<ActivesPage> createState() => _ActivesPageState();
}

class _ActivesPageState extends State<ActivesPage> {
  Color douradoEscuro = const Color.fromARGB(255, 168, 138, 78);
  List<bool> _isCheckedList = [];

  @override
  void initState() {
    super.initState();
    _isCheckedList = List<bool>.filled(widget.subclasses.length, false);
  }

  void showInfoDialog(BuildContext context, int index) {
    List<String> subtitles = [
      'Anti-acne',
      'Anti-acne',
      'Marcas',
      'Marcas',
      'Comidas',
      'Comidas',
      'Bebidas',
      'Bebidas',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            widget.subclasses[index],
            textAlign: TextAlign.center,
            style: TextStyle(color: douradoEscuro),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Mecanismo de ação:',
                style: TextStyle(fontWeight: FontWeight.bold, color: douradoEscuro),
              ),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                'Subtítulo:',
                style: TextStyle(fontWeight: FontWeight.bold, color: douradoEscuro),
              ),
              Text(
                subtitles[index],
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Fechar',
                style: TextStyle(color: douradoEscuro, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset('assets/logo.png', width: 150),
            const SizedBox(height: 50),
            Text(
              'ATIVOS',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: douradoEscuro,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.subclasses.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    activeColor: douradoEscuro,
                    value: _isCheckedList[index],
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isCheckedList[index] = newValue ?? false;
                      });
                    },
                    title: Text(
                      widget.subclasses[index],
                      style: TextStyle(fontWeight: FontWeight.bold, color: douradoEscuro),
                    ),
                    subtitle: const Text('Anti-acne'),
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () {
                        showInfoDialog(context, index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
