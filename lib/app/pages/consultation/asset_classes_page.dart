import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/data/data.dart';
import 'package:harmoniza_ativos/app/pages/consultation/asset_subclasses_page.dart';
import 'package:harmoniza_ativos/app/pages/consultation/query_definition_page.dart';

class AssetClassesPage extends StatefulWidget {
  const AssetClassesPage({super.key});

  @override
  _AssetClassesPageState createState() => _AssetClassesPageState();
}

class _AssetClassesPageState extends State<AssetClassesPage> {
  List<int> selectedAssetClasses = [];
  Color dourado = const Color.fromARGB(255, 168, 138, 78);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset(
              'assets/logo.png',
              width: 150,
            ),
            const SizedBox(height: 50),
            Text(
              'CLASSE DE ATIVOS',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: dourado,
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                String categoryName = "";
                if (index == 0) {
                  categoryName = 'Anti-acne';
                } else if (index == 1) {
                  categoryName = 'Microbiota Cutânea';
                } else if (index == 2) {
                  categoryName = 'Barreira Cutânea';
                } else if (index == 3) {
                  categoryName = 'Anti-inflamatórios';
                }
                return CheckboxListTile(
                  activeColor: douradoEscuro,
                  title: Text(
                    categoryName,
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  value: selectedAssetClasses.contains(index),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedAssetClasses.add(index);
                      } else {
                        selectedAssetClasses.remove(index);
                      }
                    });
                  },
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AssetSubclassesPage(selectedAssetClasses: selectedAssetClasses),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: dourado,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'CONTINUAR',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const QueryDefinition(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: dourado,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'VOLTAR',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
