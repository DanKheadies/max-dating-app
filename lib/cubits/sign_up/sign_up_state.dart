part of 'sign_up_cubit.dart';

// enum SignUpStatus {
//   initial,
//   submitting,
//   success,
//   error,
// }

class SignUpState extends Equatable {
  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final auth.User? user;

  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.user,
  });

  factory SignUpState.initial() {
    return const SignUpState(
      email: Email.pure(),
      password: Password.pure(),
      status: FormzSubmissionStatus.initial,
      user: null,
    );
  }

  SignUpState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    auth.User? user,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  // bool get isValid => email.isNotEmpty && password.isNotEmpty;

  // @override
  // bool get stringify => true;

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        user,
      ];
}
