import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_delivery/src/domain/entity/delivery_agent_entity.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required FirebaseAuth firebasAuth})
      : _firebaseAuth = firebasAuth,
        super(AppState()) {
    _firebaseAuth.userChanges().listen(
      (User? user) {
        deliveryState(user: user);
      },
    );
  }
  final FirebaseAuth _firebaseAuth;

  void deliveryState({required User? user}) {
    if (user == null) {
      emit(
        state.copyWith(
          appStatus: AppStatus.unauthenticated,
          user: const DeliveryAgentEntity(
            id: '',
            email: '',
            lastname: '',
            name: '',
            phone: '',
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          appStatus: AppStatus.authenticated,
          user: DeliveryAgentEntity(
            id: user.uid,
            email: user.email ?? '',
            lastname: '',
            name: '',
            phone: '',
          ),
        ),
      );
    }
  }
}
