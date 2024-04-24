import 'package:authentication_repository_firebase/authentication_repository.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:form_input/form_input.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authenticationRepository) : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LogInWithCredentials>(_onLoginWithCredentials);
  }
  final AuthenticationRepository _authenticationRepository;
  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.value);
    emit(state.copyWith(
      email: email,
      status: FormzSubmissionStatus.initial,
      isValid: Formz.validate([email, state.password]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.value);
    emit(state.copyWith(
      password: password,
      status: FormzSubmissionStatus.initial,
      isValid: Formz.validate([state.email, password]),
    ));
  }

  Future<void> _onLoginWithCredentials(
      LogInWithCredentials event, Emitter<LoginState> emit) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
