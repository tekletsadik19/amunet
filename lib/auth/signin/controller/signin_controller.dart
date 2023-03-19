import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:firebase_auth_repository/authentication_repository.dart';
import 'package:go_router/go_router.dart';
import '../../../repository/auth/auth_repo_provider.dart';
import '../../../utils/firebase.dart';
import '../../finish_setting_profile/finish_creating_profile.dart';
import '../../../models/user_model.dart' as user_model;

part 'signin_state.dart';


final signinProvider = StateNotifierProvider.autoDispose<SigninController,SigninState>(
        (ref)=>SigninController(ref.watch(authRepoProvider))
);

class SigninController extends StateNotifier<SigninState>{
  user_model.User? currentUser;
  DocumentSnapshot? documentSnapshot;
  bool loading = false;
  final AuthenticationRepository _authenticationRepository;
  SigninController(this._authenticationRepository):super(const SigninState());
  void onEmailChange(String value){
    final email = Email.dirty(value);
    state = state.copyWith(
        email: email,
        status: Formz.validate(
            [
              email,
              state.password
            ]
        )
    );
  }

  void onPasswordChange(String value){
    final password = Password.dirty(value);
    state = state.copyWith(
        password: password,
        status: Formz.validate(
            [
              state.email,
              password
            ]
        )
    );
  }

  void forgotPassword(String email,BuildContext context)async{
    try{
      await _authenticationRepository.forgotPassword(email: email);
    }on ForgotPasswordFailure catch(error){
      state = state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: error.code
      );
      showInSnackBar('Invalid Credential : Unable to login',context);
    }
  }

  signinWithEmailAndPassword(BuildContext context)async{
    if(!state.status.isValidated)return;
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    try{
      await _authenticationRepository.signinWithEmailAndPassword(
          email: state.email.value,
          password: state.email.value
      );
      state = state.copyWith(status: FormzStatus.submissionSuccess);
    } on SigninWithEmailAndPasswordFailure catch(error){
      state = state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: error.code
      );
      showInSnackBar('Invalid Credential : Unable to login',context);
    }
  }

  void signinGoogle(context)async {
    try {
      await _authenticationRepository.signInWithGoogle();
      state = state.copyWith(status: FormzStatus.submissionSuccess);
    } on SigninWithEmailAndPasswordFailure catch (error) {
      state = state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: error.code
      );
      showInSnackBar('Invalid Credential : Unable to login',context);
    }
  }


  void signOut()async {
    try {
      await _authenticationRepository.signOut();
    } on SignOutFailure catch (error) {
      state = state.copyWith(
          errorMessage: error.code
      );
    }
  }

  void showInSnackBar(String value,context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}