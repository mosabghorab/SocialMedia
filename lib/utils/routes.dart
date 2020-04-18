import 'package:flutter/material.dart';
import 'package:social_media/utils/constants.dart' as constants;
import 'package:social_media/views/screens/home_screen.dart';
import 'package:social_media/views/screens/intro_screen.dart';
import 'package:social_media/views/screens/profile_screen.dart';
import 'package:social_media/views/screens/reset_password_screen.dart';
import 'package:social_media/views/screens/setup_screen/setup_screen.dart';
import 'package:social_media/views/screens/sign_in_screen.dart';
import 'package:social_media/views/screens/sign_up_screen.dart';
import 'package:social_media/views/screens/splash_screen.dart';

final Map<String, Widget Function(BuildContext context)> routes = {
  constants.ROUTES_HOME_SCREEN: (context) => HomeScreen(),
  constants.ROUTES_SIGN_IN_SCREEN: (context) => SignInScreen(),
  constants.ROUTES_SIGN_UP_SCREEN: (context) => SignUpScreen(),
  constants.ROUTES_SETUP_SCREEN: (context) => SetupScreen(),
  constants.ROUTES_SPLASH_SCREEN: (context) => SplashScreen(),
  constants.ROUTES_FORGOT_PASSWORD_SCREEN: (context) => ResetPasswordScreen(),
  constants.ROUTES_INTRO_SCREEN: (context) => IntroScreen(),
  constants.ROUTES_PROFILE_SCREEN: (context) => ProfileScreen(),
};
