import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  Future<bool> login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw 'Insira seu e-mail e senha.';
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw 'Email ou senha incorretos.';
      }
      throw 'Erro ao fazer login: ${e.message}';
    } catch (e) {
      throw 'Erro ao fazer login: $e';
    }
  }

  Future<bool> register(String email, String password, String confirmPassword, String displayName) async {
    try {
      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        throw 'Preencha todos os campos.';
      }

      if (password != confirmPassword) {
        throw 'As senhas não correspondem.';
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(displayName);
      _user = userCredential.user;

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw 'O e-mail já está cadastrado.';
      }
      throw 'Erro ao registrar: ${e.message}';
    } catch (e) {
      throw 'Erro ao registrar: $e';
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
