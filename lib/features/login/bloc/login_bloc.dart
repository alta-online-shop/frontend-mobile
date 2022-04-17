import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mobile/features/login/bloc/login_event.dart';
import 'package:frontend_mobile/features/login/bloc/login_state.dart';
import 'package:frontend_mobile/services/auth/auth_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState(token: null)) {
    on<LoginLoading>((event, emit) async {
      try {
        String? token = await AuthService.login(event.login);

        if (token == null || token.isEmpty) {
          throw Exception('login failed');
        }

        emit(LoginState(token: token));
      } catch (e) {
        emit(LoginState(token: null, error: e.toString()));
      }
    });

    on<LoginClean>((event, emit) {
      emit(const LoginState(token: null));
    });
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
