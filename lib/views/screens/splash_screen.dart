import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/controllers/have_model_controllers/user_controller.dart';
import 'package:social_media/controllers/have_no_model_controllers/auth_controller.dart';
import 'package:social_media/utils/constants.dart' as constants;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController _authController;
  UserController _userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authController = AuthController.instance;
    _userController = UserController.instance;
  }

  void setIsFirstTime(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(
        constants.SHARED_PREFERENCES_IS_FIRST_TIME, value);
  }

  Future<bool> isFirstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences
            .getBool(constants.SHARED_PREFERENCES_IS_FIRST_TIME) ??
        true;
  }

  void _routeUser() {
    isFirstTime().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, constants.ROUTES_INTRO_SCREEN);
        setIsFirstTime(false);
      } else {
        _authController.getCurrentUser().then((value) {
          if (value == null) {
            Navigator.pushReplacementNamed(
                context, constants.ROUTES_SIGN_IN_SCREEN);
            return;
          }
          _userController.getUser(value.uid).then((value) {
            if (value.isCompletedAccount) {
              _authController.isRememberedUser().then((value) {
                if (value)
                  Navigator.pushReplacementNamed(
                      context, constants.ROUTES_HOME_SCREEN);
                else {
                  Navigator.pushReplacementNamed(
                      context, constants.ROUTES_SIGN_IN_SCREEN);
                  _authController.signOut();
                }
              });
            } else {
              _authController.isRememberedUser().then((value) {
                if (value)
                  Navigator.pushReplacementNamed(
                      context, constants.ROUTES_SETUP_SCREEN);
                else {
                  Navigator.pushReplacementNamed(
                      context, constants.ROUTES_SIGN_IN_SCREEN);
                  _authController.signOut();
                }
              });
            }
          }, onError: (error) {
            Navigator.pushReplacementNamed(
                context, constants.ROUTES_SIGN_IN_SCREEN);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _routeUser();
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.message,
          size: 100,
          color: Colors.teal,
        ),
      ),
    );
  }
}
