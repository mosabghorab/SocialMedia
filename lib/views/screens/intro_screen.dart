import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:social_media/utils/constants.dart' as constants;

class IntroScreen extends StatelessWidget {
  IntroScreen() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  void onDonePress() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroSlider(
        onDonePress: () => Navigator.pushReplacementNamed(
            context, constants.ROUTES_SIGN_IN_SCREEN),
        sizeDot: 6,
        typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
        slides: _introSlides,
        styleNameDoneBtn: TextStyle(color: Colors.teal),
        styleNameSkipBtn: TextStyle(color: Colors.black),
        colorDot: Colors.orange,
        isShowDotIndicator: true,
      ),
    );
  }
}

//                  Slides list >>>
final List<Slide> _introSlides = [
  Slide(
    styleTitle: TextStyle(color: Colors.black, fontSize: 25),
    styleDescription: TextStyle(color: Colors.black),
    widgetDescription: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          'Welcome',
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Ye indulgence unreserved connection alteration appearance",
          textAlign: TextAlign.center,
        )
      ],
    ),
    backgroundColor: Colors.white,
    widgetTitle: Image.asset(
      constants.ASSETS_IMAGE_NAME_INTRO_PAGE_1,
      height: 250,
      width: 50,
    ),
  ),
  Slide(
    styleTitle: TextStyle(color: Colors.black, fontSize: 25),
    styleDescription: TextStyle(color: Colors.black),
    widgetDescription: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          'Welcome',
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Ye indulgence unreserved connection alteration appearance",
          textAlign: TextAlign.center,
        )
      ],
    ),
    backgroundColor: Colors.white,
    widgetTitle: Image.asset(
      constants.ASSETS_IMAGE_NAME_INTRO_PAGE_2,
      height: 250,
      width: 50,
    ),
  ),
  Slide(
    styleTitle: TextStyle(color: Colors.black, fontSize: 25),
    styleDescription: TextStyle(color: Colors.black),
    widgetDescription: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          'Welcome',
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Ye indulgence unreserved connection alteration appearance",
          textAlign: TextAlign.center,
        )
      ],
    ),
    backgroundColor: Colors.white,
    widgetTitle: Image.asset(
      constants.ASSETS_IMAGE_NAME_INTRO_PAGE_3,
      height: 250,
      width: 50,
    ),
  ),
];
