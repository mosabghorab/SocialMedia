import 'package:flutter/cupertino.dart';
import 'package:social_media/controllers/have_model_controllers/user_controller.dart';
import 'package:social_media/models/user.dart';

class UserNotifier with ChangeNotifier {
  bool _isLoading;
  UserController _userController;
  List<User> _users;
  User _user;

  UserNotifier() {
    _userController = UserController.instance;
    _isLoading = false;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  List<User> get users => _users;

  set users(List<User> value) {
    _users = value;
  }

  void getAllUsers() async {
    isLoading = true;
    users = await _userController.getAllUsers();
    isLoading = false;
  }

  void getUser(String uid) async {
    isLoading = true;
    user = await _userController.getUser(uid);
    isLoading = false;
  }

  void updateUser(String uid, User user) async {
    isLoading = true;
    await _userController.updateUser(uid, user);
    isLoading = false;
  }
}
