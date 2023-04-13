part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  submitting,
  success,
  error,
}

@immutable
class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final auth.User? user;

  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    this.user,
  });

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      status: LoginStatus.initial,
      user: null,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    auth.User? user,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        user,
      ];
}
