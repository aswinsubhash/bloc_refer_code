part of 'auth_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuhtInitial extends AuthenticationState {
  final bool success;
  final String message;
  AuhtInitial({
    required this.success,
    required this.message,
  });
}

final class AuthLoading extends AuthenticationState {}

final class UserLoggedOut extends AuthenticationState {}
