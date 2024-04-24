part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

final class EmailChanged extends LoginEvent {
  EmailChanged({required this.value});
  final String value;
}

final class PasswordChanged extends LoginEvent {
  PasswordChanged({required this.value});
  final String value;
}

final class LogInWithCredentials extends LoginEvent {
  const LogInWithCredentials();
}

final class LogInWithGoogle extends LoginEvent {
  const LogInWithGoogle();
}
