import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDatasource {
  FirebaseAuthDatasource({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

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
      await _firestore.collection('deliveryAgents').doc(userCredential.user?.uid).set(
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
