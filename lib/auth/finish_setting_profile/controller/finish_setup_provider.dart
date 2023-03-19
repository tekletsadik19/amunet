import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user_model.dart' as user_model;
import 'finish_profile_controller.dart';
import 'finish_setting_profile_state.dart';

final finishSettingUpProfileProvider = StateNotifierProvider.family<FinishProfileController,
    FinishProfileState,user_model.User>(
        (ref,user){
      return FinishProfileController(
          user: user
      );
    }
);