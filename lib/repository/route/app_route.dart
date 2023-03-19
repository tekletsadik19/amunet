import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../auth/controller/authentication_controller.dart';
import '../../auth/finish_setting_profile/finish_creating_profile.dart';

import '../../pages/homepage.dart';
import '../../pages/landing/landing.dart';
import '../../../auth/auth_view.dart';



final routerProvider = Provider(
      (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
          routes: <GoRoute>[
            GoRoute(
              path: 'finish_signing',
              builder: (context, state) =>  FinishUpProfile(),
            ),
          ]
      ),
      GoRoute(
        path: '/amunet',
        builder: (context, state) =>  Landing(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) =>
            AuthViewPage(
              showSignIn: state.extra!=null?state.extra as bool:false,
            ),
      ),
    ],
    redirect: (state) {
      final authenticationState = ref.read(authProvider);
      final fromParam = (authenticationState.status == AuthenticationStatus.authenticated) ? '' : '?from=${state.subloc}';
      if(authenticationState.status == AuthenticationStatus.authenticated){
        if(state.subloc == '/finish_signing'){
          return state.subloc == '/finish_signing' ? null : '/finish_signing';
        }
        if(state.subloc == '/verification'){
          return state.subloc == '/verification' ? null : '/verification';
        }
        if(state.subloc == '/otp_verify'){
          return state.subloc == '/otp_verify' ? null : '/otp_verify';
        }
        if(state.subloc == '/fenote_yt'){
          return state.subloc == '/fenote_yt' ? null : '/fenote_yt';
        }
        if(state.subloc == '/create_book'){
          return state.subloc == '/create_book' ? null : '/create_book';
        }
        return state.subloc == '/' ? null : '/';
      }
      if(authenticationState.status != AuthenticationStatus.authenticated){
        if(state.subloc == '/auth'){
          return state.subloc == '/auth' ? null : '/auth';
        }
        return state.subloc == '/amunet' ? null : '/amunet';
      }

      return null;
    },
  ),
);
