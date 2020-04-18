import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:social_media/controllers/have_no_model_controllers/auth_controller.dart';
import 'package:social_media/utils/constants.dart' as constants;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _email, _password, _name, _phoneNumber, _description;
  GlobalKey<FormState> _formKey;
  AuthController _authController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _formKey = GlobalKey();
    _authController = AuthController.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.arrow_forward),
      ),
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 300,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _authController.signOut();
                    Navigator.pushReplacementNamed(
                        context, constants.ROUTES_SIGN_IN_SCREEN);
                  }),
              pinned: false,
              floating: true,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              //backgroundColor: Colors.transparent,
              title: Text('Profile profile info'),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Image.asset(
                          constants.ASSETS_IMAGE_NAME_DEFAULT_USER_COVER_IMAGE,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      child: Container(
                        decoration: ShapeDecoration(
                            shape: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(color: Colors.teal, width: 3),
                        )),
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(constants
                              .ASSETS_IMAGE_NAME_DEFAULT_USER_PERSONAL_IMAGE),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {},
                    trailing: Icon(Icons.edit),
                    leading: Icon(Icons.person),
                    title: Text('Name'),
                    subtitle: Text('Your name'),
                  ),
                  ListTile(
                    onTap: () {},
                    trailing: Icon(Icons.edit),
                    leading: Icon(Icons.email),
                    title: Text('Email'),
                    subtitle: Text('Your email'),
                  ),
                  ListTile(
                    onTap: () {},
                    trailing: Icon(Icons.edit),
                    leading: Icon(Icons.phone),
                    title: Text('Phone Number'),
                    subtitle: Text('Your phone number'),
                  ),
                  ListTile(
                    onTap: () {},
                    trailing: Icon(Icons.edit),
                    leading: Icon(Icons.person_pin),
                    title: Text('Gender'),
                    subtitle: Text('Male'),
                  ),
                  ListTile(
                    onTap: () {},
                    trailing: Icon(Icons.edit),
                    leading: Icon(Icons.place),
                    title: Text('Country'),
                    subtitle: Text('Palestine'),
                  ),
                  ListTile(
                    onTap: () {},
                    trailing: Icon(Icons.edit),
                    leading: Icon(Icons.description),
                    title: Text('Description'),
                    subtitle: Text('Hello Developers i am here'),
                  ),
                  ListTile(
                    onTap: () {},
                    trailing: Icon(Icons.edit),
                    leading: Icon(Icons.description),
                    title: Text('Date of birth'),
                    subtitle: Text('2019-10-12'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
