import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mobile/features/register/bloc/register_event.dart';
import 'package:frontend_mobile/features/register/bloc/register_state.dart';
import 'package:frontend_mobile/services/auth/auth_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterLoading>((event, emit) async {
      try {
        await AuthService.register(event.register);
        emit(const RegisterState());
      } catch (e) {
        emit(RegisterState(error: e.toString()));
      }
    });
  }

  @override
  void onTransition(Transition<RegisterEvent, RegisterState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
