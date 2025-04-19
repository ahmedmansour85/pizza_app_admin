// Corrected import for logging

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'entities/entity.dart';
import 'models/my_user.dart';
import 'user_repo.dart';

class FirebaseUserRepo extends UserRepo {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');
  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  @override
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        yield MyUser.empty;
      } else {
        final docSnapshot = await userCollection.doc(firebaseUser.uid).get();
        if (docSnapshot.exists) {
          yield MyUser.fromEntity(
              MyUserEntity.fromDocument(docSnapshot.data()!));
        } else {
          yield MyUser.empty;
        }
      }
    });
  }

  @override
  Future<void> signin(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      if (kDebugMode) {
        print('Signup Error: ${e.toString()}');
      }
      rethrow;
    }
  }

  @override
  Future<MyUser> signup(MyUser user, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      user.userid = credential.user!.uid;
      await setUserData(user);
      return user;
    } catch (e) {
      if (kDebugMode) {
        print('Signup Error: ${e.toString()}');
      }
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await userCollection.doc(user.userid).set(user.toEntity().toDocument());
    } catch (e) {
      if (kDebugMode) {
        print('Signup Error: ${e.toString()}');
      }
      rethrow;
    }
  }

  @override
  Future<void> signout() async {
    try {
      await _firebaseAuth.signOut(); // Implemented signout
    } catch (e) {
      if (kDebugMode) {
        print('Signup Error: ${e.toString()}');
      }
      rethrow;
    }
  }
}
