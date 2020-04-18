
import 'package:flutter/foundation.dart';

class SignInScreenNotifier with ChangeNotifier{
  bool _rememberMe;
  bool _passwordVisibility;

  SignInScreenNotifier(
      ) {
    _rememberMe = false;
    _passwordVisibility = false;
  }

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }


  bool get passwordVisibility => _passwordVisibility;

  set passwordVisibility(bool value) {
    _passwordVisibility = value;
    notifyListeners();
  }

  void changeRememberMe(bool value) {
      rememberMe = value;
  }

  void changePasswordVisibility() {
   passwordVisibility = !passwordVisibility;
  }

}
