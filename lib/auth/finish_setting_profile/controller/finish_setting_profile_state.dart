import 'package:freezed_annotation/freezed_annotation.dart';
part 'finish_setting_profile_state.freezed.dart';
@freezed
abstract class FinishProfileState<T> with _$FinishProfileState<T>{
  const factory FinishProfileState.data(T user) = _Data;
  const factory FinishProfileState.loading() = _Loading;
  const factory FinishProfileState.error(Object? e, [StackTrace? stk]) = _Error;
}