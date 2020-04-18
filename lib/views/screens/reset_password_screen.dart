import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:social_media/notifiers/auth_notifier/auth_notifier.dart';
import 'package:social_media/utils/constants.dart' as constants;
import 'package:social_media/utils/functions.dart' as functions;
import 'package:social_media/views/widgets/custom_fade_animation.dart';
import 'package:social_media/views/widgets/stacked_icons.dart';

class ResetPasswordScreenBody extends StatefulWidget {
  @override
  _ResetPasswordScreenBodyState createState() =>
      _ResetPasswordScreenBodyState();
}

class _ResetPasswordScreenBodyState extends State<ResetPasswordScreenBody>
    with TickerProviderStateMixin {
  String _email;
  AuthNotifier _authNotifier;
  GlobalKey<FormState> _formKey;

  // initialize data  >>>
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _formKey = GlobalKey();
  }

  // method for send an email to the user who want to reset password  >>>
  void _resetPassword() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await _authNotifier.resetPassword(_email);
        functions.showMessage(constants.SUCCESS_RESET_PASSWORD_EMAIL_SENT,
            functions.MessageType.MESSAGE_SUCCESS);
      } catch (error) {
        functions.showMessage(
            error.message, functions.MessageType.MESSAGE_FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _authNotifier = Provider.of<AuthNotifier>(context, listen: false);
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
                            "Reset Password",
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
                                          _resetPassword();
                                        },
                                        child: Text('Send'),
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

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => AuthNotifier(),
      child: BotToastInit(
        child: ResetPasswordScreenBody(),
      ),
    );
  }
}
