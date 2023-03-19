import 'package:equatable/equatable.dart';

class AuthUser extends Equatable{
  final String id;
  final String? name;
  final String? email;
  final bool isEmailVerified;

  const AuthUser({
    this.name,
    required this.id,
    this.email,
    this.isEmailVerified = false
  });
  static const empty =  AuthUser(id: '');
  bool get isEmpty => this == AuthUser.empty;

  @override

  List<Object?> get props => [
    email,
    id,
    name,
    isEmailVerified
  ];


}