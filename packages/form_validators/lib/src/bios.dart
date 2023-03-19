import 'package:form_validators/form_validators.dart';

enum BiosValidationError{invalid}
class Bios extends FormzInput<String,BiosValidationError>{
  const Bios.pure():super.pure('');
  const Bios.dirty([String value='']):super.dirty(value);

  @override
  BiosValidationError? validator(String value) {
    if(value.length > 70){
      return BiosValidationError.invalid;
    }else{
      return null;
    }
  }

  static String? showBiosErrorMessage(BiosValidationError? error){
    if (error == BiosValidationError.invalid) {
      return 'Bios is too long';
    } else {
      return 'error';
    }
  }
}