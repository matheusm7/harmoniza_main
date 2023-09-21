import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadProfilePicture(String userId) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return null;

    final file = File(pickedImage.path);
    const fileName = 'profilePicture.jpg';
    final reference = _storage.ref().child('users/$userId/$fileName');
    final uploadTask = reference.putFile(file);
    final snapshot = await uploadTask;
    final imageUrl = await snapshot.ref.getDownloadURL();

    // Atualiza a foto de perfil no Firebase Authentication
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(imageUrl);

    return imageUrl;
  }
}
