import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/controllers/have_model_controllers/user_controller.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/utils/constants.dart' as constants;
import 'package:social_media/utils/enums.dart';
import 'package:social_media/utils/functions.dart' as functions;

// This class for controlling the auth operations >>>
class AuthController {
  FirebaseAuth _firebaseAuth;
  GoogleSignIn _googleSignIn;
  FacebookLogin _facebookLogin;
  UserController _userController;
  static AuthController _instance;

  // Private constructor
  AuthController._() {
    _firebaseAuth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    _facebookLogin = FacebookLogin();
    _userController = UserController.instance;
  }

// Singleton pattern >>>
  static AuthController get instance {
    if (_instance != null) return _instance;
    return _instance = AuthController._();
  }

  // This will return the current user (may be null)  >>>
  Future<FirebaseUser> getCurrentUser() async {
    return _firebaseAuth.currentUser();
  }

// Create new user using email and password >>>
  Future<FirebaseUser> createUserWithEmailAndPassword(
      String email, String password) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser createdUser = authResult.user;
    await _userController.addUser(User(
        email: email,
        password: password,
        isCompletedAccount: false,
        creationTime: Timestamp.fromDate(createdUser.metadata.creationTime),
        lastSignIn: Timestamp.now(),
        signInMethod:
            functions.getSignInMethod(SignInMethod.EMAIL_AND_PASSWORD),
        uid: createdUser.uid));
    setRememberedUser(false);
    return createdUser;
  }

  // Sign in with email and password  >>
  Future<AuthStatus> signInWithEmailAndPassword(
      String email, String password, bool isRememberMe) async {
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser currentUser = authResult.user;
    User user = await _userController.getUser(currentUser.uid);
    setRememberedUser(isRememberMe);
    user.lastSignIn = Timestamp.now();
    user.creationTime = Timestamp.fromDate(currentUser.metadata.creationTime);
    await _userController.updateUser(user.uid, user);
    return user.isCompletedAccount
        ? AuthStatus.AUTH_COMPLETED
        : AuthStatus.AUTH_NOT_COMPLETED;
  }

  // Sign in with google  >>
  Future<AuthStatus> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    AuthResult authResult =
        await _firebaseAuth.signInWithCredential(authCredential);
    FirebaseUser currentUser = authResult.user;
    User user = await _userController.getUser(currentUser.uid);
    setRememberedUser(true);
    if (user != null) {
      user.lastSeen = Timestamp.now();
      await _userController.updateUser(currentUser.uid, user);
      return user.isCompletedAccount
          ? AuthStatus.AUTH_COMPLETED
          : AuthStatus.AUTH_NOT_COMPLETED;
    }
    await _userController.addUser(User(
        email: currentUser.email,
        password: 'No Password',
        signInMethod: functions.getSignInMethod(SignInMethod.GOOGLE),
        isCompletedAccount: false,
        uid: currentUser.uid,
        personalImage: currentUser.photoUrl,
        creationTime: Timestamp.fromDate(currentUser.metadata.creationTime),
        lastSignIn: Timestamp.now(),
        name: currentUser.displayName));
    return AuthStatus.AUTH_NOT_COMPLETED;
  }

// Sign in with facebook  >>
  Future<AuthStatus> signInWithFacebook() async {
    FacebookLoginResult facebookLoginResult =
        await _facebookLogin.logIn(['email', 'public_profile']);
    AuthCredential authCredential = FacebookAuthProvider.getCredential(
        accessToken: facebookLoginResult.accessToken.token);
    AuthResult authResult =
        await _firebaseAuth.signInWithCredential(authCredential);
    FirebaseUser currentUser = authResult.user;
    User user = await _userController.getUser(currentUser.uid);
    setRememberedUser(true);
    if (user != null) {
      user.lastSeen = Timestamp.now();
      await _userController.updateUser(currentUser.uid, user);
      return user.isCompletedAccount
          ? AuthStatus.AUTH_COMPLETED
          : AuthStatus.AUTH_NOT_COMPLETED;
    }
    await _userController.addUser(User(
      email: currentUser.email,
      password: 'No Password',
      signInMethod: functions.getSignInMethod(SignInMethod.FACEBOOK),
      isCompletedAccount: false,
      uid: currentUser.uid,
      personalImage: currentUser.photoUrl,
      name: currentUser.displayName,
      creationTime: Timestamp.fromDate(currentUser.metadata.creationTime),
      lastSignIn: Timestamp.now(),
    ));
    return AuthStatus.AUTH_NOT_COMPLETED;
  }

  // This will sign out the current user (make it null) >>>
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

// method for setting the user status is remembered or not  >>>
  Future<void> setRememberedUser(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(
        constants.SHARED_PREFERENCES_REMEMBER_ME, value);
  }

// method for getting the user status is remembered or not  >>>
  Future<bool> isRememberedUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences
            .getBool(constants.SHARED_PREFERENCES_REMEMBER_ME) ??
        false;
  }

// method for recover the user password  >>>
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
