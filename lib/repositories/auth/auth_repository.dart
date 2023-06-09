import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:max_dating_app/repositories/repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<auth.User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      return user;
    } on auth.FirebaseAuthException catch (err) {
      throw Exception(err.message);
    } catch (_) {
      print(_);
    }

    // Avoid hint-error
    return null;
  }

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on auth.FirebaseAuthException catch (err) {
      throw Exception(err.message);
    } catch (_) {
      print('err: $_');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
