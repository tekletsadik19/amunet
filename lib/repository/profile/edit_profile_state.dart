import 'package:freezed_annotation/freezed_annotation.dart';
part 'edit_profile_state.freezed.dart';
@freezed
abstract class EditProfileState<T> with _$EditProfileState<T>{
  const factory EditProfileState.data(T user) = _Data;
  const factory EditProfileState.loading() = _Loading;
  const factory EditProfileState.error(Object? e, [StackTrace? stk]) = _Error;
}