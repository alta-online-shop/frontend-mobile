import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String? error;
  const RegisterState({
    this.error,
  });

  get isError => error != null || error!.isNotEmpty;

  @override
  get props => [error];
}
