import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:social_media/notifiers/auth_notifier/auth_notifier.dart';
import 'package:social_media/notifiers/screens_notifier/sign_up_screen_notifier.dart';
import 'package:social_media/utils/constants.dart' as constants;
import 'package:social_media/utils/functions.dart' as functions;
import 'package:social_media/views/widgets/custom_fade_animation.dart';
import 'package:social_media/views/widgets/stacked_icons.dart';

class SignUpScreenBody extends StatefulWidget {
  @override
  _SignUpScreenBodyState createState() => _SignUpScreenBodyState();
}

class _SignUpScreenBodyState extends State<SignUpScreenBody>
    with TickerProviderStateMixin {
  SignUpScreenNotifier _signUpScreenNotifier;
  String _email, _password, _confirmPassword;
  AuthNotifier _authNotifier;
  GlobalKey<FormState> _formKey;

  // initialize data  >>>
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _formKey = GlobalKey();
  }

  // method for user routing  >>>
  void routeUser(FirebaseUser currentUser) async {
    Navigator.pushNamed(context, constants.ROUTES_SETUP_SCREEN,
        arguments: currentUser);
  }

  // method for creating a new user and route him to setup screen  >>>
  void _createUserWithEmailAndPassword() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_password != _confirmPassword) {
        functions.showMessage(
            constants.ERROR_CONFIRM_PASSWORD_NOT_MATCH_PASSWORD,
            functions.MessageType.MESSAGE_FAILED);
        return;
      }
      try {
        FirebaseUser currentUser = await _authNotifier
            .createUserWithEmailAndPassword(_email, _password);
        routeUser(currentUser);
      } catch (error) {
        functions.showMessage(
            error.message, functions.MessageType.MESSAGE_FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    _signUpScreenNotifier =
        Provider.of<SignUpScreenNotifier>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
          child: Selector<AuthNotifier, bool>(
            selector: (_, value) => value.isLoading,
            builder: (_, isLoading, __) {
              if (isLoading) return LinearProgressIndicator();
              return Container();
            },
          ),
          preferredSize: Size.fromHeight(_authNotifier.isLoading ? 5 : 0)),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            // <Header Section>
            Stack(
              children: <Widget>[
                Container(
                  height: 580,
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
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
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
                      1.3,
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
                                          Selector<SignUpScreenNotifier, bool>(
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
                                                  onPressed: _signUpScreenNotifier
                                                      .changePasswordVisibility,
                                                ),
                                                icon: Icon(Icons.lock),
                                                labelText: 'Enter password',
                                              ),
                                            ),
                                          ),
                                          Selector<SignUpScreenNotifier, bool>(
                                            selector: (_, value) =>
                                                value.confirmPasswordVisibility,
                                            builder: (_,
                                                    confirmPasswordVisibility,
                                                    __) =>
                                                TextFormField(
                                              keyboardType: TextInputType.text,
                                              onSaved: (value) {
                                                _confirmPassword = value.trim();
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
                                              obscureText:
                                                  confirmPasswordVisibility,
                                              decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                      confirmPasswordVisibility
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off),
                                                  onPressed: _signUpScreenNotifier
                                                      .changeConfirmPasswordVisibility,
                                                ),
                                                icon: Icon(Icons.lock),
                                                labelText: 'Confirm password',
                                              ),
                                            ),
                                          )
                                        ],
                                      ))),
                              Row(
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
                                                width: 0, color: Colors.white)),
                                        onPressed: () {
                                          _createUserWithEmailAndPassword();
                                        },
                                        child: Text('Sign Up'),
                                        textColor: Colors.white,
                                        color: Colors.teal,
                                        padding: EdgeInsets.all(18),
                                      ),
                                    ),
                                  ),
                                ],
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
            // </Footer Section>
          ],
        ),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          builder: (_) => SignUpScreenNotifier(),
        )
      ],
      child: BotToastInit(
        child: SignUpScreenBody(),
      ),
    );
  }
}
