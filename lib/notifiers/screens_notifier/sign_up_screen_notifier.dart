
import 'package:flutter/foundation.dart';

class SignUpScreenNotifier with ChangeNotifier{
  bool _passwordVisibility;
  bool _confirmPasswordVisibility;

  SignUpScreenNotifier(
      ) {
    _passwordVisibility = false;
    _confirmPasswordVisibility = false;
  }

  bool get passwordVisibility => _passwordVisibility;

  set passwordVisibility(bool value) {
    _passwordVisibility = value;
    notifyListeners();
  }


  bool get confirmPasswordVisibility => _confirmPasswordVisibility;

  set confirmPasswordVisibility(bool value) {
    _confirmPasswordVisibility = value;
    notifyListeners();
  }

  void changePasswordVisibility() {
   passwordVisibility = !passwordVisibility;
  }

  void changeConfirmPasswordVisibility() {
    confirmPasswordVisibility = !confirmPasswordVisibility;
  }

}
