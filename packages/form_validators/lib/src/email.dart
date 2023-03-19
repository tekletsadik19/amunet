import 'package:form_validators/form_validators.dart';

enum EmailValidationError{empty,invalid}

const String _kEmailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class Email extends FormzInput<String,EmailValidationError>{
  const Email.pure():super.pure('');
  const Email.dirty([String value='']):super.dirty(value);
  static final _regEx = RegExp(_kEmailPattern);
  @override
  EmailValidationError? validator(String value) {
    if(_regEx.hasMatch(value)){
      return null;
    }else if(value.isEmpty){
      return EmailValidationError.empty;
    }else{
      return EmailValidationError.invalid;
    }
  }

  static String? showEmailErrorMessege(EmailValidationError? error){
    if (error == EmailValidationError.empty) {
      return 'Empty email';
    } else if (error == EmailValidationError.invalid) {
      return 'Invalid email';
    } else {
      return 'error';
    }
  }
  
}