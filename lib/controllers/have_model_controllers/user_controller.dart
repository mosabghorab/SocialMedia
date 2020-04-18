import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/utils/constants.dart' as constants;

// This class(Controller) for all user operations  >>>
class UserController {
  static UserController _instance;

  UserController._();

  static UserController get instance {
    if (_instance != null) return _instance;
    return _instance = UserController._();
  }

  // This method to add new user >>>
  Future<void> addUser(User user) async {
    await Firestore.instance
        .collection(constants.COLLECTION_USERS)
        .document(user.uid)
        .setData(user.asMap());
  }

// This method to delete user >>>
  Future<void> deleteUser(String uid) async {
    await Firestore.instance
        .collection(constants.COLLECTION_USERS)
        .document(uid)
        .delete();
  }

// This method to update an existed user >>>
  Future<void> updateUser(String uid, User user) async {
    await Firestore.instance
        .collection(constants.COLLECTION_USERS)
        .document(uid)
        .setData(user.asMap());
  }

// This method to get  a specific user >>>
  Future<User> getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await Firestore.instance
        .collection(constants.COLLECTION_USERS)
        .document(uid)
        .get();
    return fromMap(documentSnapshot.data)..uid = documentSnapshot.documentID;
  }

// This method to convert an map of user data to object of user >>>
  User fromMap(Map<String, dynamic> map) {
    return User(
      name: map[constants.FIELD_NAME],
      coverImage: map[constants.FIELD_COVER_IMAGE],
      email: map[constants.FIELD_EMAIL],
      phoneNumber: map[constants.FIELD_PHONE_NUMBER],
      description: map[constants.FIELD_DESCRIPTION],
      friendsCount: map[constants.FIELD_FRIENDS_COUNT],
      friendsRequestsCount: map[constants.FIELD_FRIENDS_REQUESTS_COUNT],
      isCompletedAccount: map[constants.FIELD_IS_COMPLETED_ACCOUNT],
      lastSeen: map[constants.FIELD_LAST_SEEN],
      password: map[constants.FIELD_PASSWORD],
      personalImage: map[constants.FIELD_PERSONAL_IMAGE],
      status: map[constants.FIELD_STATUS],
      uid: '',
      country: map[constants.FIELD_COUNTRY],
      dateOfBirth: map[constants.FIELD_DATE_OF_BIRTH],
      gender: map[constants.FIELD_GENDER],
      isVerifiedAccount: map[constants.FIELD_IS_VERIFIED_ACCOUNT],
      lastSignIn: map[constants.FIELD_LAST_SIGN_IN],
      signInMethod: map[constants.FIELD_SIGN_IN_METHOD],
    );
  }

// This method to get all stored users >>>
  Future<List<User>> getAllUsers() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(constants.COLLECTION_USERS)
        .orderBy(constants.FIELD_NAME)
        .getDocuments();
    return querySnapshot.documents.map<User>((document) {
      return fromMap(document.data)..uid = document.documentID;
    }).toList();
  }
}
