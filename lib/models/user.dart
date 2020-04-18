import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/utils/constants.dart' as constants;

class User {
  String _name;
  String _uid;
  String _email;
  String _password;
  String _personalImage;
  String _coverImage;
  int _friendsCount;
  int _friendsRequestsCount;
  String _phoneNumber;
  String _description;
  int _status;
  int _dateOfBirth;
  bool _isCompletedAccount;
  Timestamp _lastSeen;
  int _signInMethod;
  bool _isVerifiedAccount;
  int _country;
  int _gender;
  Timestamp _lastSignIn;
  Timestamp _creationTime;

  User(
      {String name,
      @required String email,
      @required String uid,
      String password,
      String personalImage,
      String coverImage,
      String phoneNumber,
      String description,
      int signInMethod,
      bool isVerifiedAccount,
      int country,
      int gender,
      int status,
      @required bool isCompletedAccount,
      int friendsRequestsCount,
      int friendsCount,
      Timestamp lastSeen,
      int dateOfBirth,
      Timestamp creationTime,
      Timestamp lastSignIn}) {
    this._name = name ?? '';
    this._email = email;
    this._password = password ?? '';
    this._personalImage = personalImage ?? 'No Image Found';
    this._coverImage = coverImage ?? 'No Image Found';
    this._friendsCount = friendsCount ?? 0;
    this._friendsRequestsCount = friendsRequestsCount ?? 0;
    this._phoneNumber = phoneNumber ?? 'No Phone Number Found';
    this._description = description ?? 'No Description Found';
    this._status = status ?? -1;
    this._signInMethod = signInMethod ?? -1;
    this._gender = gender ?? -1;
    this._dateOfBirth = dateOfBirth ?? -1;
    this._creationTime = creationTime ?? null;
    this._country = country ?? -1;
    this._isVerifiedAccount = isVerifiedAccount ?? false;
    this._isCompletedAccount = isCompletedAccount;
    this._lastSeen = lastSeen ?? null;
    this._lastSignIn = lastSignIn ?? null;
    this._uid = uid;
  }

  Map<String, dynamic> asMap() {
    return {
      constants.FIELD_NAME: this._name,
      constants.FIELD_PHONE_NUMBER: this._phoneNumber,
      constants.FIELD_EMAIL: this._email,
      constants.FIELD_PASSWORD: this._password,
      constants.FIELD_DESCRIPTION: this._description,
      constants.FIELD_STATUS: this._status,
      constants.FIELD_FRIENDS_COUNT: this._friendsCount,
      constants.COLLECTION_FRIENDS_REQUESTS: this._friendsRequestsCount,
      constants.FIELD_IS_COMPLETED_ACCOUNT: this._isCompletedAccount,
      constants.FIELD_PERSONAL_IMAGE: this._personalImage,
      constants.FIELD_COVER_IMAGE: this._coverImage,
      constants.FIELD_SIGN_IN_METHOD: this._signInMethod,
      constants.FIELD_LAST_SIGN_IN: this._lastSignIn,
      constants.FIELD_LAST_SEEN: this._lastSeen,
      constants.FIELD_IS_VERIFIED_ACCOUNT: this._isVerifiedAccount,
      constants.FIELD_GENDER: this._gender,
      constants.FIELD_COUNTRY: this._country,
      constants.FIELD_DATE_OF_BIRTH: this._dateOfBirth,
      constants.FIELD_CREATION_TIME: this._creationTime,
    };
  }

  Timestamp get lastSignIn => _lastSignIn;

  set lastSignIn(Timestamp value) {
    _lastSignIn = value;
  }

  int get dateOfBirth => _dateOfBirth;

  set dateOfBirth(int value) {
    _dateOfBirth = value;
  }

  Timestamp get lastSeen => _lastSeen;

  set lastSeen(Timestamp value) {
    _lastSeen = value;
  }

  bool get isCompletedAccount => _isCompletedAccount;

  set isCompletedAccount(bool value) {
    _isCompletedAccount = value;
  }

  int get status => _status;

  set status(int value) {
    _status = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  int get friendsRequestsCount => _friendsRequestsCount;

  set friendsRequestsCount(int value) {
    _friendsRequestsCount = value;
  }

  int get friendsCount => _friendsCount;

  set friendsCount(int value) {
    _friendsCount = value;
  }

  String get coverImage => _coverImage;

  set coverImage(String value) {
    _coverImage = value;
  }

  String get personalImage => _personalImage;

  set personalImage(String value) {
    _personalImage = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get signInMethod => _signInMethod;

  set loginMethod(int value) {
    _signInMethod = value;
  }

  bool get isVerifiedAccount => _isVerifiedAccount;

  set isVerifiedAccount(bool value) {
    _isVerifiedAccount = value;
  }

  int get country => _country;

  set country(int value) {
    _country = value;
  }

  int get gender => _gender;

  set gender(int value) {
    _gender = value;
  }

  Timestamp get creationTime => _creationTime;

  set creationTime(Timestamp value) {
    _creationTime = value;
  }
}
