import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth_repository/authentication_repository.dart';
import '../../../repository/auth/auth_repo_provider.dart';
import '../../../utils/firebase.dart';
import '../../finish_setting_profile/finish_creating_profile.dart';
import '../../../models/user_model.dart' as user_model;



part 'signup_state.dart';

final signupProvider = StateNotifierProvider.autoDispose<SignupController,SignupState>(
    (ref)=>SignupController(ref.watch(authRepoProvider))
);

class SignupController extends StateNotifier<SignupState>{
  final AuthenticationRepository _authenticationRepository;
  SignupController(this._authenticationRepository):super(const SignupState());
  user_model.User? currentUser;
  bool loading = false;

  void onNameChange(String value){
    final name = Name.dirty(value);
    state = state.copyWith(
      name: name,
      status: Formz.validate(
        [
          name,
          state.email,
          state.password
        ]
      )
    );
  }

  void onEmailChange(String value){
    final email = Email.dirty(value);
    state = state.copyWith(
        email: email,
        status: Formz.validate(
            [
              state.name,
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
              state.name,
              state.email,
              password
            ]
        )
    );
  }

  signupWithEmailAndPassword(context)async{
    loading = true;
    if(!state.status.isValidated)return;
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    try{
      await _authenticationRepository.signupWithEmailAndPassword(
          email: state.email.value,
          password: state.email.value
      );
      state = state.copyWith(status: FormzStatus.submissionSuccess);
    } on SignupWithEmailAndPasswordFailure catch(error){
        state = state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: error.code
        );
        showInSnackBar('unable to signup',context);
    }
  }

  void signupGoogle(context)async{
    try{
      await _authenticationRepository.signInWithGoogle();
      state = state.copyWith(status: FormzStatus.submissionSuccess);
    } on SignupWithEmailAndPasswordFailure catch(error){
      state = state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: error.code
      );
    }
  }


  void showInSnackBar(String value,context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}