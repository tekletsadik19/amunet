import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/profile/edit_profile_state.dart';
import '../../repository/profile/profile_controller.dart';
import '../../models/user_model.dart' as user_model;
import '../../utils/firebase.dart';

final getUserDataStream = FutureProvider.autoDispose.family<DocumentSnapshot,String>(
        (ref,userId) => usersRef.doc(userId).get()
);

final editProfileProvider = StateNotifierProvider.family<EditProfileController,
    EditProfileState,user_model.User>(
        (ref,user){
      return EditProfileController(
          user: user
      );
    }
);


