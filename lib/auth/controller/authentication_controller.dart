import 'dart:async';
import 'package:firebase_auth_repository/authentication_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import '../../repository/auth/auth_repo_provider.dart';

part  'authentication_state.dart';

final authProvider = StateNotifierProvider<AuthController,AuthenticationState>(
        (ref) => AuthController(ref.watch(authRepoProvider))
);
class AuthController extends StateNotifier<AuthenticationState>{
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription  subsription;

  AuthController(this._authenticationRepository):super(const AuthenticationState.unauthenticated()){
    _authenticationRepository.user.listen((user)=>_onUserChanged(user));
  }
  void _onUserChanged(AuthUser user){
    if(user.isEmpty){
      state = AuthenticationState.unauthenticated();
    }else{
      state = AuthenticationState.authenticated(user);
    }
  }
  void _onSignOut(){
    _authenticationRepository.signOut();
  }

}