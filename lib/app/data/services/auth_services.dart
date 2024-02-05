import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fAuth;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../model/user_model.dart';
import 'firebase_response.dart';



class AuthServices {
  AuthServices._();

  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future<FirebaseResponse<User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userAuth =
          await fAuth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userAuth.user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userAuth.user!.uid)
            .get();
        User? user;
        if (userDoc.exists) {
          user = User.fromJson(userDoc.data()!);
          return FirebaseResponse(
              message: 'Berhasil masuk.',
              data: user,
              success: true);
        } else {
          return FirebaseResponse(
              message: 'Gagal masuk, Silakan coba lagi.',
              data: null,
              success: false);
        }
      } else {
        return FirebaseResponse(
            message: 'Gagal masuk, Silakan coba lagi.',
            data: null,
            success: false);
      }
    } on fAuth.FirebaseAuthException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      log(e.code, stackTrace: s);
      return FirebaseResponse(
          message: _firebaseException(e), data: null, success: false);
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return FirebaseResponse(
          message: 'Gagal masuk, Silakan coba lagi.',
          data: null,
          success: false);
    }
  }

  static String _firebaseException(exception) {
    if (exception is fAuth.FirebaseAuthException) {
      switch (exception.code) {
        case 'invalid-email':
          return "Alamat email tidak valid.";
        case 'wrong-password':
          return 'Password salah.';
        case 'user-not-found':
          return 'Tidak ada pengguna dengan alamat email yang diberikan.';
        case 'user-disabled':
          return 'Pengguna ini telah dinonaktifkan.';
        case 'too-many-requests':
          return 'Terlalu banyak percobaan masuk sebagai pengguna ini.';
      }
      return 'Error Firebase yang tidak terduga, Silakan coba lagi.';
    } else {
      return 'Gagal masuk, Silakan coba lagi.';
    }
  }

  static firebaseSignUpWithEmailAndPassword(
    String emailAddress,
    String password,
    String userName,
  ) async {
    try {
      fAuth.UserCredential result = await fAuth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);

      User user = User(
          email: emailAddress,
          userID: result.user?.uid ?? '',
          userName: userName,
          fcmToken: await firebaseMessaging.getToken() ?? '');
      String? errorMessage = await firebaseCreateNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return 'Couldn\'t sign up for firebase, Please try again.';
      }
    } on fAuth.FirebaseAuthException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      String message = 'Couldn\'t sign up';
      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email already in use, Please pick another email!';
          break;
        case 'invalid-email':
          message = 'Enter valid e-mail';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          message = 'Password must be more than 5 characters';
          break;
        case 'too-many-requests':
          message = 'Too many requests, Please try again later.';
          break;
      }
      return message;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return 'Couldn\'t sign up';
    }
  }

  static Future<String?> firebaseCreateNewUser(User user) async {
    try {
      await firestore.collection('users').doc(user.userID).set(user.toJson());
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return "Couldn't sign up";
    }
    return null;
  }

  static Future<User?> updateCurrentUser(User user) async {
    try {
      await firestore
          .collection('users')
          .doc(user.userID)
          .set(user.toJson(), SetOptions(merge: true));
      return user;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return null;
  }

  static Future<FirebaseResponse<User>> getUser(String uid) async {
    final user = await firestore.collection('users').doc(uid).get();
    if (user.exists) {
      return FirebaseResponse(
          message: 'Berhasil masuk.',
          data: User.fromJson(user.data()!),
          success: true);
    } else {
      return FirebaseResponse(
          message: 'Gagal masuk, Silakan coba lagi.',
          data: null,
          success: false);
    }
  }
}
