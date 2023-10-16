import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/app/data/data.dart';
import 'package:harmoniza_ativos/app/pages/main_page.dart';

import '../../../controller/profile/profile_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ProfileService _profileService = ProfileService();

  var displayName = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final imageUrl = currentUser?.photoURL;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
                        ),
                        if (_isLoading)
                          const Positioned.fill(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () async {
                              final user = FirebaseAuth.instance.currentUser;
                              final imageUrl = await _profileService.uploadProfilePicture(user!.uid);
                              if (imageUrl != null) {
                                setState(
                                  () {
                                    user.updatePhotoURL(imageUrl);
                                    _isLoading = true;
                                  },
                                );
                              }
                            },
                            icon: const Icon(Icons.camera_alt),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () async {
                          final user = FirebaseAuth.instance.currentUser;
                          final imageUrl = await _profileService.uploadProfilePicture(user!.uid);
                          if (imageUrl != null) {
                            setState(() {
                              _isLoading = false;
                              user.updatePhotoURL(imageUrl);
                            });
                          }
                        },
                        icon: const Icon(Icons.camera_alt),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: displayName,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: douradoEscuro),
                  onPressed: () async {
                    try {
                      final user = FirebaseAuth.instance.currentUser!;

          
                      if (displayName.text.isNotEmpty) {
                        await user.updateDisplayName(displayName.text);
                      }

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
