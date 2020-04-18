import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

// This class for controlling the auth operations >>>
class StorageController {
  static StorageController _instance;

  FirebaseStorage _firebaseStorage;

  // Private constructor
  StorageController._() {
    _firebaseStorage = FirebaseStorage.instance;
  }

// Singleton pattern >>>
  static StorageController get instance {
    if (_instance != null) return _instance;
    return _instance = StorageController._();
  }

  // method for uploading an file >>>
  Future<String> uploadFile(String filePath, File file) async {
    StorageTaskSnapshot storageTaskSnapshot =
        await _firebaseStorage.ref().child(filePath).putFile(file).onComplete;
    return storageTaskSnapshot.uploadSessionUri.toString();
  }
}
