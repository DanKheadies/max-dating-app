import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
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
    emit(
      state.copyWith(
        email: value,
        status: SignUpStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: SignUpStatus.initial,
      ),
    );
  }

  Future<void> signUpWithCredentials() async {
    if (!state.isValid || state.status == SignUpStatus.submitting) {
      emit(
        state.copyWith(
          status: SignUpStatus.submitting,
        ),
      );
    }
    try {
      var user = await _authRepository.signUp(
        email: state.email,
        password: state.password,
      );

      emit(
        state.copyWith(
          status: SignUpStatus.success,
          user: user,
        ),
      );
    } catch (_) {
      print('error');
    }
  }
}
