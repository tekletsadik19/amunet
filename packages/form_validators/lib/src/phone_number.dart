import 'package:form_validators/form_validators.dart';

enum PhoneNumberValidationError{empty,invalid}
class PhoneNumber extends FormzInput<String,PhoneNumberValidationError>{
  const PhoneNumber.pure():super.pure('');
  const PhoneNumber.dirty([String value='']):super.dirty(value);

  @override
  PhoneNumberValidationError? validator(String value) {
    if(value.isEmpty){
      return PhoneNumberValidationError.empty;
    }else if(double.tryParse(value.substring(1)) == null || value.length !=10){
      return PhoneNumberValidationError.invalid;
    }else{
      return null;
    }
  }

  static String? showPhoneNumberErrorMessege(PhoneNumberValidationError? error){
    if (error == PhoneNumberValidationError.empty) {
      return 'Empty phone number';
    } else if (error == PhoneNumberValidationError.invalid) {
      return 'phone number must be start from 09';
    } else {
      return 'error';
    }
  }
}