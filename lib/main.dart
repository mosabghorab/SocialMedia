import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:social_media/utils/routes.dart' as routes;

import 'utils/constants.dart' as constants;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      title: 'Social Media',
      theme: ThemeData(primaryColor: Colors.teal, primarySwatch: Colors.teal),
      initialRoute: constants.ROUTES_SPLASH_SCREEN,
      routes: routes.routes,
    );
  }
}
