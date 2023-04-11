import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:max_dating_app/repositories/auth/auth_repository.dart';
import 'package:meta/meta.dart';

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

  void signUpWithCredentials() async {
    if (!state.isValid) return;

    try {
      await _authRepository.signUp(
        email: state.email,
        password: state.password,
      );

      emit(
        state.copyWith(
          status: SignUpStatus.success,
        ),
      );
    } catch (_) {}
  }
}
