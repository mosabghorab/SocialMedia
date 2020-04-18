import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:social_media/utils/constants.dart' as constants;
import 'package:social_media/utils/enums.dart';

// enum for message types >>>
enum MessageType { MESSAGE_FAILED, MESSAGE_SUCCESS }

// function for showing an message >>>
void showMessage(String message, MessageType messageType) {
  if (message == null) return;
  if (messageType == MessageType.MESSAGE_FAILED)
    BotToast.showNotification(
        trailing: (_) => Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
        title: (_) => Text('ERROR !! :', style: TextStyle(color: Colors.red)),
        subtitle: (_) => Text(message, style: TextStyle(color: Colors.red)),
        leading: (_) => Icon(
              Icons.error,
              color: Colors.red,
            ));
  else
    BotToast.showNotification(
        trailing: (_) => Icon(
              Icons.arrow_forward_ios,
              color: Colors.teal,
            ),
        title: (_) =>
            Text('SUCCESS !! :', style: TextStyle(color: Colors.teal)),
        subtitle: (_) => Text(message, style: TextStyle(color: Colors.teal)),
        leading: (_) => Icon(
              Icons.done,
              color: Colors.teal,
            ));
}

int getSignInMethod(SignInMethod signInMethod) {
  switch (signInMethod) {
    case SignInMethod.EMAIL_AND_PASSWORD:
      return constants.SIGN_IN_METHOD_EMAIL_AND_PASSWORD;
    case SignInMethod.GOOGLE:
      return constants.SIGN_IN_METHOD_GOOGLE;
    case SignInMethod.FACEBOOK:
      return constants.SIGN_IN_METHOD_FACEBOOK;
    default:
      return -1;
  }
}

int getUserStatus(UserStatus userStatus) {
  switch (userStatus) {
    case UserStatus.ONLINE:
      return constants.USER_STATUS_OFFLINE;
    case UserStatus.OFFLINE:
      return constants.USER_STATUS_OFFLINE;
    case UserStatus.BUSY:
      return constants.USER_STATUS_BUSY;
    default:
      return -1;
  }
}

int getUserGender(UserGender userGender) {
  switch (userGender) {
    case UserGender.MALE:
      return constants.USER_GENDER_MALE;
    case UserGender.FEMALE:
      return constants.USER_GENDER_FEMALE;
    default:
      return -1;
  }
}