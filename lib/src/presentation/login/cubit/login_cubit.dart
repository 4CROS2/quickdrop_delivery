import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quickdrop_delivery/src/domain/entity/delivery_agent_entity.dart';
import 'package:quickdrop_delivery/src/domain/usecase/auth_usecase.dart';

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
      case '506':
        return 'cuenta no registrada';
      default:
        return localizations.unknownError;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      final DeliveryAgentEntity response =
          await _authUseCase.login(email: email, password: password);
      emit(
        LoginSuccess(deliveryAgent: response),
      );
    } catch (e) {
      emit(
        LoginError(
          message: e.toString(),
        ),
      );
    }
  }
}
