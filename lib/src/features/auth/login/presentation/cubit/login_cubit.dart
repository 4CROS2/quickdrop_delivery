import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_delivery/src/core/generated/app_localizations.dart';
import 'package:quickdrop_delivery/src/features/auth/login/domain/entity/delivery_agent_entity.dart';
import 'package:quickdrop_delivery/src/features/auth/login/domain/usecase/auth_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required AuthUseCase authUseCase})
      : _authUseCase = authUseCase,
        super(const LoginState());
  final AuthUseCase _authUseCase;

  String localizationResponse({
    required String code,
    required AppLocalizations localizations,
  }) {
    switch (code) {
      case '500':
        return localizations.invalidCredential;
      case '501':
        return localizations.invalidEmail;
      case '502':
        return localizations.userDisabled;
      case '503':
        return localizations.userNotFound;
      case '504':
        return localizations.wrongPassword;
      case '505':
        return 'cuenta no registrada en la aplicacion';
      case '506':
        return 'error al autenticar';
      default:
        return localizations.unknownError;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      await _authUseCase.login(
        email: email,
        password: password,
      );
    } catch (e) {
      if (!isClosed) {
        emit(
          LoginError(
            message: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      emit(LoginLoading());
      await _authUseCase.googleSignin();
    } catch (e) {
      if (!isClosed) {
        emit(
          LoginError(
            message: e.toString(),
          ),
        );
      }
    }
  }
}
