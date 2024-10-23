import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdrop_delivery/src/core/extensions/document_snapshot_stream_extension.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseAuthDatasource {
  FirebaseAuthDatasource({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  Stream<Map<String, dynamic>?> deliveryStatus() {
    return _firebaseAuth.userChanges().switchMap((User? user) {
      if (user != null) {
        return _firestore
            .collection('deliveryAgents')
            .doc(user.uid)
            .snapshots()
            .toMapJsonStream();
      } else {
        // Si no hay usuario autenticado, devuelve null
        return Stream<Map<String, dynamic>?>.value(<String, dynamic>{});
      }
    });
  }

  Future<UserCredential> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Verificar que el usuario esté en la colección correspondiente
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore
              .collection('deliveryAgents')
              .doc(userCredential.user?.uid)
              .get();

      if (!docSnapshot.exists) {
        await logout();
        throw '506';
      }
      return userCredential;
    } on FirebaseAuthException catch (exception) {
      String errorCode;
      switch (exception.code) {
        case 'invalid-credential':
          errorCode = '500';
          break;
        case 'invalid-email':
          errorCode = '501';
          break;
        case 'user-disabled':
          errorCode = '502';
          break;
        case 'user-not-found':
          errorCode = '503';
          break;
        case 'wrong-password':
          errorCode = '504';
          break;
        default:
          errorCode = '505';
      }
      throw errorCode;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserCredential> signUpWithData({
    required String email,
    required String password,
    required String name,
    required String lastName,
    required String phone,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Guardar información adicional en Firestore
      await _firestore
          .collection('deliveryAgents')
          .doc(userCredential.user?.uid)
          .set(
        <String, String>{
          'name': name,
          'lastName': lastName,
          'phone': phone,
          'email': email,
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (exception) {
      String errorMessage;
      switch (exception.code) {
        case 'email-already-in-use':
          errorMessage = 'El correo electrónico ya está en uso.';
          break;
        case 'invalid-email':
          errorMessage = 'El correo electrónico no es válido.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Operación no permitida.';
          break;
        case 'weak-password':
          errorMessage = 'La contraseña es demasiado débil.';
          break;
        default:
          errorMessage = 'Ocurrió un error desconocido.';
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
