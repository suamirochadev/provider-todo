// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider_todo/app/exception/auth.exception.dart';
import 'package:provider_todo/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(
          message: e.message ?? 'Erro ao realizar login. Platform Exception');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'invalid-credential') {
        throw AuthException(
            message: 'Email ou senha inválidos, tente mais uma vez.');
      }
      throw AuthException(
          message:
              e.message ?? 'Erro ao realizar login. Firebase Auth Exception');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final login = await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (login.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (login.contains('google')) {
        throw AuthException(
            message: 'Cadastro realizado com o google, não pode ser resetado.');
      } else {
        throw AuthException(message: 'Email não cadastrado no sistema.');
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(
          message: e.message ?? 'Erro ao realizar login. Platform Exception');
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? login;
    // abre a janelinha do google
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      // se for diferente de null, significa que o usuário já está cadastrado
      if (googleUser != null) {
        login =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);

        // se o login for diferente de password, significa que o usuário já está cadastrado
        if (login.contains('password')) {
          throw AuthException(
            message: 'Email já cadastrado no sistema.',
          );
        } else {
          // se o login for diferente de google, significa que o usuário já está cadastrado
          final googleAuth = await googleUser.authentication;
          final firebaseProvider = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          final userCredential = await _firebaseAuth.signInWithCredential(
            firebaseProvider,
          );
          return userCredential.user;
        }
      }
      // caso tenha mais de um provedor ex: facebook, twitter, etc
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(message: 'Login inválido. ${login?.join(', ')}');
      } else {
        throw AuthException(
          message:
              e.message ?? 'Erro ao realizar login. Firebase Auth Exception',
        );
      }
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
}
