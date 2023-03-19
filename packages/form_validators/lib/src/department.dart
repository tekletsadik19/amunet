import 'package:form_validators/form_validators.dart';

enum DepartmentValidationError{empty,invalid}
class Department extends FormzInput<String,DepartmentValidationError>{
  const Department.pure():super.pure('');
  const Department.dirty([String value='']):super.dirty(value);

  @override
  DepartmentValidationError? validator(String value) {
    if(value.isEmpty){
      return DepartmentValidationError.empty;
    }else if(value.length <5){
      return DepartmentValidationError.invalid;
    }else{
      return null;
    }
  }

  static String? showDepartmentErrorMessege(DepartmentValidationError? error){
    if (error == DepartmentValidationError.empty) {
      return 'Empty department';
    } else if (error == DepartmentValidationError.invalid) {
      return 'department is too short';
    } else {
      return 'error';
    }
  }
}