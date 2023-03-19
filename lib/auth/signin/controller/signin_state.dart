part of'signin_controller.dart';

class SigninState extends Equatable{
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;

  const SigninState({
    this.email =const Email.pure(),
    this.password =const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage});

  SigninState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage
  }){
    return SigninState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage
    );
  }
  @override
  List<Object?> get props => [
    email,
    password,
    status
  ];
}