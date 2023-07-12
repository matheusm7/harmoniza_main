import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main_page.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var displayName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Editar perfil',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              TextFormField(
                controller: displayName,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      FirebaseAuth.instance.currentUser!.updateDisplayName(displayName.text);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text('Atualizar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
