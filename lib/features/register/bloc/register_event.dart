import 'package:equatable/equatable.dart';
import 'package:frontend_mobile/services/auth/auth_service.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterLoading extends RegisterEvent {
  final Register register;
  RegisterLoading({
    required this.register,
  });

  @override
  List<Object?> get props => [register];
}

// Logout
class LoginClean extends RegisterEvent {}
