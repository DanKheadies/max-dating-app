import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;

// import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<auth.User?> signUp({
    required String email,
    required String password,
  }) async {
    print('sign up');
    try {
      print('try to..');
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('creds: $credential');

      final user = credential.user;
      return user;
    } catch (_) {
      print('error in auth repo sign up');
      print(_);
    }

    // Avoid hint-error
    return null;
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
