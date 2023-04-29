import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import 'package:max_dating_app/repositories/repositories.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;

  SignUpCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(SignUpState.initial());

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

  Future<void> signUpWithCredentials() async {
    if (Formz.validate([state.email, state.password]) ||
        state.status == FormzSubmissionStatus.inProgress) return;

    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      ),
    );

    // if (!state.isValid || state.status == SignUpStatus.submitting) {
    //   emit(
    //     state.copyWith(
    //       status: SignUpStatus.submitting,
    //     ),
    //   );
    // }
    try {
      var user = await _authRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );

      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          user: user,
        ),
      );
    } catch (err) {
      print('err: $err');
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}
