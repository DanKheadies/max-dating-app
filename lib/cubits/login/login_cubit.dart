import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import 'package:max_dating_app/repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(LoginState.initial());

  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.failure,
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.failure,
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (state.status == FormzSubmissionStatus.success) return;

    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      ),
    );
    try {
      await _authRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
        ),
      );
    } on Exception catch (err) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.canceled,
          errorMessage: err.toString(),
        ),
      );
    } catch (err) {
      print('err: $err');
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.canceled,
          errorMessage: err.toString(),
        ),
      );
    }
  }
}
