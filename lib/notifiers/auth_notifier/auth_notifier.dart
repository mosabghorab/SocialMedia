import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media/controllers/have_no_model_controllers/auth_controller.dart';
import 'package:social_media/utils/enums.dart';

class AuthNotifier with ChangeNotifier {
  bool _isLoading;
  AuthController _authController;

  AuthNotifier() {
    _authController = AuthController.instance;
    _isLoading = false;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // method for sign in with google   >>>
  Future<AuthStatus> signInWithGoogle() async {
    return await _authController.signInWithGoogle();
  }

  // method for sign in with facebook   >>>
  Future<AuthStatus> signInWithFacebook() async {
    return await _authController.signInWithFacebook();
  }

// method for sign in with email and password  >>>
  Future<AuthStatus> signInWithEmailAndPassword(
      String email, String password, bool isRememberMe) async {
    isLoading = true;
    AuthStatus authStatus = await _authController.signInWithEmailAndPassword(
        email, password, isRememberMe);
    isLoading = false;
    return authStatus;
  }

  // method for creating a new user >>>
  Future<FirebaseUser> createUserWithEmailAndPassword(email, password) async {
    isLoading = true;
    FirebaseUser createdUser =
        await _authController.createUserWithEmailAndPassword(email, password);
    isLoading = false;
    return createdUser;
  }

  // method for send an email to the user who want to reset password  >>>
  Future<void> resetPassword(String email) async {
    isLoading = true;
    await _authController.resetPassword(email);
    isLoading = false;
  }

// This will return the current user (may be null)  >>>
  Future<FirebaseUser> getCurrentUser() async {
    return _authController.getCurrentUser();
  }
}
