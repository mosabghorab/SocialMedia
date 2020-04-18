import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/notifiers/user_notifier/user_notifier.dart';
import 'package:social_media/utils/constants.dart' as constants;
import 'package:social_media/utils/enums.dart';

class ImagesPage extends StatefulWidget {
  User _user;
  ImagesPage(this._user);

  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  File _personalImage;
  File _coverImage;
  UserNotifier _userNotifier;

  // method for saving data in the current user  >>
  void uploadsImages() {}

  Widget buildAlertDialog(ImageType imageType) => AlertDialog(
        title: Text('Choose from'),
        content: Container(
          height: 100,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Camera'),
                onTap: () {
                  pickImage(imageType, ImageFrom.CAMERA);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Gallery'),
                onTap: () {
                  pickImage(imageType, ImageFrom.GALLERY);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      );

  void pickImage(ImageType imageType, ImageFrom imageFrom) async {
    try {
      if (imageFrom == ImageFrom.CAMERA) {
        if (imageType == ImageType.PERSONAL_IMAGE)
          _personalImage =
              await ImagePicker.pickImage(source: ImageSource.camera);
        else
          _coverImage = await ImagePicker.pickImage(source: ImageSource.camera);
      } else {
        if (imageType == ImageType.PERSONAL_IMAGE)
          _personalImage =
              await ImagePicker.pickImage(source: ImageSource.gallery);
        else
          _coverImage =
              await ImagePicker.pickImage(source: ImageSource.gallery);
      }
    } catch (e) {
      print("-------------------------ERROR !! : ${e.message}------------");
    }
  }

  @override
  Widget build(BuildContext context) {
    _userNotifier = Provider.of<UserNotifier>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 16),
      child: ListView(
        children: <Widget>[
          Text(
            'Welcome Body !!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, color: Colors.teal),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'here you can continue your information here you can continue your information here you can continue your information',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(
            height: 40,
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showGeneralDialog(
                    transitionDuration: Duration(milliseconds: 300),
                    barrierDismissible: true,
                    barrierLabel: '',
                    context: context,
                    transitionBuilder: (context, a1, a2, widget) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (Curves.bounceInOut.transform(a1.value) - 1.0) *
                                200,
                            0.0,
                            0.0),
                        child: Opacity(
                            opacity: a1.value,
                            child: buildAlertDialog(ImageType.COVER_IMAGE)),
                      );
                    },
                    pageBuilder: (BuildContext context, Animation animation,
                        Animation secondaryAnimation) {},
                  );
                },
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: _coverImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.file(
                            _coverImage,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: _coverImage == null
                                  ? Image.asset(
                                      constants
                                          .ASSETS_IMAGE_NAME_DEFAULT_USER_COVER_IMAGE,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.file(
                                      _coverImage,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                            Opacity(
                              opacity: 0.6,
                              child: Container(
                                height: 300,
                                decoration: ShapeDecoration(
                                    color: Colors.black,
                                    shape: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    )),
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ],
                        ),
                ),
              ),
              Positioned(
                top: 200,
                child: GestureDetector(
                  onTap: () {
                    showGeneralDialog(
                      transitionDuration: Duration(milliseconds: 300),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform(
                          transform: Matrix4.translationValues(
                              (Curves.bounceInOut.transform(a1.value) - 1.0) *
                                  200,
                              0.0,
                              0.0),
                          child: Opacity(
                              opacity: a1.value,
                              child:
                                  buildAlertDialog(ImageType.PERSONAL_IMAGE)),
                        );
                      },
                      pageBuilder: (BuildContext context, Animation animation,
                          Animation secondaryAnimation) {},
                    );
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                        shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Colors.teal, width: 3),
                    )),
                    height: 100,
                    width: 100,
                    child: personalImage != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(personalImage),
                          )
                        : Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: personalImage == null
                                    ? AssetImage(constants
                                        .ASSETS_IMAGE_NAME_DEFAULT_USER_PERSONAL_IMAGE)
                                    : FileImage(personalImage),
                              ),
                              Opacity(
                                opacity: 0.6,
                                child: Container(
                                  decoration: ShapeDecoration(
                                      color: Colors.black,
                                      shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        borderSide: BorderSide(
                                            style: BorderStyle.none, width: 2),
                                      )),
                                ),
                              ),
                              Icon(
                                Icons.edit,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
