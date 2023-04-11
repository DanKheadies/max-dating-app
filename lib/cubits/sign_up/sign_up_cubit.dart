import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

// import 'package:max_dating_app/blocs/blocs.dart';
// import 'package:max_dating_app/models/models.dart';
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
    // var state = this.state;
    print('sign up');
    if (!state.isValid || state.status == SignUpStatus.submitting) {
      // var state = this.state;
      print('submitting');
      emit(
        state.copyWith(
          status: SignUpStatus.submitting,
        ),
      );
    }
    try {
      print('trying');
      var user = await _authRepository.signUp(
        email: state.email,
        password: state.password,
      );
      print('emitting');

      emit(
        state.copyWith(
          status: SignUpStatus.success,
          user: user,
        ),
      );
      print('success');
    } catch (_) {
      print('error');
    }
  }
}
