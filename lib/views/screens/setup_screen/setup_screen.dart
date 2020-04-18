import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/notifiers/screens_notifier/setup_screen_notifier.dart';
import 'package:social_media/notifiers/user_notifier/user_notifier.dart';

class SetupScreenBody extends StatefulWidget {
  @override
  _SetupScreenBodyState createState() => _SetupScreenBodyState();
}

class _SetupScreenBodyState extends State<SetupScreenBody> {
  FirebaseUser _currentUser;
  PageController _pageController;
  UserNotifier _userNotifier;
  SetupScreenNotifier _setupScreenNotifier;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _pageController = PageController();
  }

  //method for update the user data >>>
  void updateUser(String uid, User user) {
    try {
      _userNotifier.updateUser(uid, user);
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    _currentUser = ModalRoute.of(context).settings.arguments;
    _setupScreenNotifier =
        Provider.of<SetupScreenNotifier>(context, listen: false);
    _userNotifier = Provider.of<UserNotifier>(context, listen: false);
    _userNotifier.getUser(_currentUser.uid);
    return Scaffold(
      appBar: PreferredSize(
          child: Container(
              padding: EdgeInsets.only(top: 10),
              child: Selector<SetupScreenNotifier, int>(
                selector: (_, value) => value.pageIndex,
                builder: (_, pageIndex, __) => Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('${pageIndex + 1} of 2',
                      style: TextStyle(color: Colors.teal, fontSize: 15)),
                ),
              )),
          preferredSize: Size.fromHeight(30)),
      floatingActionButton: Selector<SetupScreenNotifier, int>(
        selector: (_, value) => value.pageIndex,
        builder: (_, pageIndex, __) => FloatingActionButton(
          onPressed: () {
            if (pageIndex == 0)
              _pageController.animateToPage(1,
                  duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
            //else
            //updateUser();
          },
          child: pageIndex == 0 ? Icon(Icons.arrow_forward) : Icon(Icons.save),
        ),
      ),
      body: PageView(
        onPageChanged: (page) {
          _setupScreenNotifier.pageIndex = page;
        },
        controller: _pageController,
        children: <Widget>[
          page1(context),
          page2(),
        ],
      ),
    );
  }
}

class SetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => UserNotifier(),
        ),
        ChangeNotifierProvider(
          builder: (context) => SetupScreenNotifier(),
        ),
      ],
      child: BotToastInit(
        child: SetupScreenBody(),
      ),
    );
  }
}
