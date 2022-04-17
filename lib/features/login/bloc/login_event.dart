import 'package:equatable/equatable.dart';
import 'package:frontend_mobile/services/auth/auth_service.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginEvent {
  final Login login;
  LoginLoading({
    required this.login,
  });

  @override
  List<Object?> get props => [login];
}

// Logout
class LoginClean extends LoginEvent {}
