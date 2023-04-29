part of 'login_cubit.dart';

// enum LoginStatus {
//   initial,
//   submitting,
//   success,
//   error,
// }

@immutable
class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  final auth.User? user;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
    this.user,
  });

  // bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  factory LoginState.initial() {
    return const LoginState(
      email: Email.pure(),
      password: Password.pure(),
      status: FormzSubmissionStatus.initial,
      errorMessage: null,
      user: null,
    );
  }

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    String? errorMessage,
    auth.User? user,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  // @override
  // bool get stringify => true;

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        errorMessage,
        user,
      ];
}
