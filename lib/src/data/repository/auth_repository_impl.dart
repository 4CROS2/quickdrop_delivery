import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdrop_delivery/src/data/datasource/firebase_auth_datasource.dart';
import 'package:quickdrop_delivery/src/data/model/delivery_agent_model.dart';
import 'package:quickdrop_delivery/src/domain/repository/auth_repository.dart';

class IAuthRepository implements AuthRepository {
  IAuthRepository({
    required FirebaseAuthDatasource datasource,
  }) : _datasource = datasource;

  final FirebaseAuthDatasource _datasource;

  @override
  Stream<DeliveryAgentModel> deliveryStatus() {
    // Obtener el stream del datasource
    final Stream<Map<String, dynamic>?> response = _datasource.deliveryStatus();

    // Convertir el Stream<Map<String, dynamic>?> a Stream<DeliveryAgentModel>
    final Stream<DeliveryAgentModel> deliveryAgentStream = response
        .where((Map<String, dynamic>? data) =>
            data != null) // Filtrar los datos nulos
        .map(
          (Map<String, dynamic>? data) =>
              DeliveryAgentModel.fromJson(json: data!),
        );
    return deliveryAgentStream;
  }

  @override
  Future<DeliveryAgentModel> login(
      {required String email, required String password}) async {
    final UserCredential userCredential = await _datasource.loginWithEmail(
      email: email,
      password: password,
    );
    return DeliveryAgentModel.fromFireBase(credential: userCredential);
  }

  @override
  Future<DeliveryAgentModel> signUp({
    required String name,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential = await _datasource.signUpWithData(
      email: email,
      password: password,
      name: name,
      lastName: lastName,
      phone: phone,
    );
    return DeliveryAgentModel.fromFireBase(
      credential: userCredential,
    );
  }

  @override
  Future<void> logout() async {
    await _datasource.logout();
  }

  @override
  Future<DeliveryAgentModel> googleSignin() async {
    final UserCredential response = await _datasource.signInWithGoogle();
    return DeliveryAgentModel.fromFireBase(credential: response);
  }
}
