import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:social_media/icons/custom_icons.dart' as customIcons;
import 'package:social_media/notifiers/auth_notifier/auth_notifier.dart';
import 'package:social_media/notifiers/screens_notifier/sign_in_screen_notifier.dart';
import 'package:social_media/utils/constants.dart' as constants;
import 'package:social_media/utils/enums.dart';
import 'package:social_media/utils/functions.dart' as functions;
import 'package:social_media/views/widgets/custom_fade_animation.dart';
import 'package:social_media/views/widgets/stacked_icons.dart';

class SignInScreenBody extends StatefulWidget {
  @override
  _SignInScreenBodyState createState() => _SignInScreenBodyState();
}

class _SignInScreenBodyState extends State<SignInScreenBody>
    with TickerProviderStateMixin {
  String _email, _password;
  AuthNotifier _authNotifier;
  SignInScreenNotifier _signInScreenNotifier;
  GlobalKey<FormState> _formKey;

  // initialize data  >>>
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _formKey = GlobalKey();
  }

  // method for user routing  >>>
  void routeUser(AuthStatus authStatus) async {
    FirebaseUser currentUser = await _authNotifier.getCurrentUser();
    if (authStatus == AuthStatus.AUTH_COMPLETED) {
      Navigator.pushNamed(context, constants.ROUTES_HOME_SCREEN,
          arguments: currentUser);
    } else if (authStatus == AuthStatus.AUTH_NOT_COMPLETED) {
      Navigator.pushNamed(context, constants.ROUTES_SETUP_SCREEN,
          arguments: currentUser);
    }
  }

  // method for sign in with email and password  >>>
  void _signInWithEmailAndPassword() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        AuthStatus authStatus = await _authNotifier.signInWithEmailAndPassword(
            _email, _password, _signInScreenNotifier.rememberMe);
        routeUser(authStatus);
      } catch (error) {
        functions.showMessage(
            error.message, functions.MessageType.MESSAGE_FAILED);
      }
    }
  }

  // method for sign in with google  >>>
  void _signInWithGoogle() async {
    try {
      AuthStatus authStatus = await _authNotifier.signInWithGoogle();
      routeUser(authStatus);
    } catch (error) {
      functions.showMessage(
          error.message, functions.MessageType.MESSAGE_FAILED);
    }
  }

  // method for sign in with facebook  >>>
  void _signInWithFacebook() async {
    try {
      AuthStatus authStatus = await _authNotifier.signInWithFacebook();
      routeUser(authStatus);
    } catch (error) {
      functions.showMessage(
          error.message, functions.MessageType.MESSAGE_FAILED);
    }
  }

  @override
  Widget build(BuildContext context) {
    _authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    _signInScreenNotifier =
        Provider.of<SignInScreenNotifier>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
          child: Selector<AuthNotifier, bool>(
            selector: (_, value) => value.isLoading,
            builder: (_, isLoading, __) => isLoading
                ? LinearProgressIndicator()
                : Container(
                    height: 0,
                  ),
          ),
          preferredSize:
              _authNotifier.isLoading ? Size.fromHeight(5) : Size.zero),
      body: Container(
        child: ListView(
          children: <Widget>[
            // <Header Section>
            Stack(
              children: <Widget>[
                Container(
                  height: 570,
                ),
                Positioned(
                  child: Container(
                    decoration: ShapeDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(constants
                                .ASSETS_IMAGE_NAME_DEFAULT_USER_COVER_IMAGE)),
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.none),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20)))),
                    width: double.infinity,
                    height: 300,
                  ),
                ),
                Positioned(
                  child: Opacity(
                    opacity: 0.8,
                    child: Container(
                      decoration: ShapeDecoration(
                          color: Colors.teal,
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)))),
                      width: double.infinity,
                      height: 300,
                    ),
                  ),
                ),
                Positioned(
                    left: 20,
                    top: 10,
                    child: CustomFadeAnimation(
                        2,
                        Image.asset(
                          '${constants.ASSETS_IMAGES_FOLDER_PATH}light-1.png',
                          height: 150,
                        ))),
                Positioned(
                    right: 20,
                    top: 10,
                    child: CustomFadeAnimation(
                        2.5,
                        Image.asset(
                          '${constants.ASSETS_IMAGES_FOLDER_PATH}light-1.png',
                          height: 100,
                        ))),
                Container(
                  decoration: ShapeDecoration(
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.none),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)))),
                  width: double.infinity,
                  height: 300,
                  child: CustomFadeAnimation(
                    1,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StakedIcons(),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 12.0),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 230,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: CustomFadeAnimation(
                      1.5,
                      Card(
                        elevation: 5,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(style: BorderStyle.none)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 0.0),
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onSaved: (value) {
                                              _email = value.trim();
                                            },
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return constants
                                                    .ERROR_EMAIL_REQUIRED;
                                              else
                                                return null;
                                            },
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.email),
                                              labelText: 'Enter email address',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Selector<SignInScreenNotifier, bool>(
                                            selector: (_, value) =>
                                                value.passwordVisibility,
                                            builder:
                                                (_, passwordVisibility, __) =>
                                                    TextFormField(
                                              keyboardType: TextInputType.text,
                                              onSaved: (value) {
                                                _password = value.trim();
                                              },
                                              validator: (value) {
                                                if (value.isEmpty)
                                                  return constants
                                                      .ERROR_PASSWORD_REQUIRED;
                                                else if (value.length < 6)
                                                  return constants
                                                      .ERROR_PASSWORD_LENGTH;
                                                return null;
                                              },
                                              obscureText: passwordVisibility,
                                              decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  icon: Icon(passwordVisibility
                                                      ? Icons.visibility
                                                      : Icons.visibility_off),
                                                  onPressed: _signInScreenNotifier
                                                      .changePasswordVisibility,
                                                ),
                                                icon: Icon(Icons.lock),
                                                labelText: 'Enter password',
                                              ),
                                            ),
                                          )
                                        ],
                                      ))),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 5.0, top: 10.0),
                                      child: RaisedButton(
                                        shape: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide: BorderSide(
                                              style: BorderStyle.none,
                                            )),
                                        onPressed: () {
                                          _signInWithEmailAndPassword();
                                        },
                                        child: Text('Sign in'),
                                        textColor: Colors.teal,
                                        color: Colors.teal,
                                        padding: EdgeInsets.all(18),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Selector<SignInScreenNotifier, bool>(
                                          selector: (_, value) =>
                                              value.rememberMe,
                                          builder: (_, rememberMe, __) =>
                                              Checkbox(
                                                  value: rememberMe,
                                                  onChanged:
                                                      _signInScreenNotifier
                                                          .changeRememberMe),
                                        ),
                                        Selector<SignInScreenNotifier, bool>(
                                          selector: (_, value) =>
                                              value.rememberMe,
                                          builder: (_, rememberMe, __) => Text(
                                            'Remember me',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: rememberMe
                                                    ? Colors.teal
                                                    : Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 20.0, top: 10.0),
                                child: FlatButton(
                                  onPressed: () => Navigator.pushNamed(context,
                                      constants.ROUTES_FORGOT_PASSWORD_SCREEN),
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.teal),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustomFadeAnimation(
              2.0,
              Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Or with'),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFF3c5a99)),
                          child: IconButton(
                              onPressed: () {
                                _signInWithFacebook();
                              },
                              icon: Icon(
                                customIcons.facebook,
                                color: Colors.white,
                              ))),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red[400]),
                          child: IconButton(
                              onPressed: () {
                                _signInWithGoogle();
                              },
                              icon: Icon(
                                customIcons.googlePlus,
                                color: Colors.white,
                              )))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account? ",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.teal,
                        )),
                    FlatButton(
                        onPressed: () => Navigator.pushNamed(
                            context, constants.ROUTES_SIGN_UP_SCREEN),
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.teal[800],
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                ),
              ]),
            ),
            // </Footer Section>
          ],
        ),
      ),
    );
  }
}

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          builder: (_) => SignInScreenNotifier(),
        )
      ],
      child: BotToastInit(
        child: SignInScreenBody(),
      ),
    );
  }
}
