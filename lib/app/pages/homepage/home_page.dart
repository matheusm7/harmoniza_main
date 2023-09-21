import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/query button/query_button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Color dourado = const Color.fromARGB(255, 168, 138, 78);
    final currentUser = FirebaseAuth.instance.currentUser;
    final imageUrl = currentUser?.photoURL;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Row(
                children: [
                  Icon(Icons.menu, size: 30, color: Theme.of(context).colorScheme.primary),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'CONSULTAS',
                      style: GoogleFonts.poppins(fontSize: 15, color: dourado, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 100,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 20,
                            child: Container(
                              color: dourado,
                            ),
                          ),
                          Positioned(
                            top: 30,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              color: Theme.of(context).colorScheme.secondary,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'PLANO',
                                          style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: dourado,
                                          ),
                                        ),
                                        Text(
                                          '0',
                                          style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: dourado,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'GRATUITO',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 200),
            const QueryButton(
              title: 'INICIAR CONSULTA',
              icon: Icons.play_circle_fill,
            ),
          ],
        ),
      ),
    );
  }
}
