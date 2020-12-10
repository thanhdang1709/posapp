import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:mal_app_call/screens/home/home.dart';
import 'dart:async';

import 'package:get/get.dart';

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation(
      {Key key,
      this.buttonController,
      this.isLoginSuccess = 0,
      this.redirectTo})
      : buttonSqueezeanimation = new Tween(
          begin: 320.0,
          end: 70.0,
        ).animate(
          new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(
              0.0,
              0.10,
            ),
          ),
        ),
        buttomZoomOut = new Tween(
          begin: 70.0,
          end: 5.0,
        ).animate(
          new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(
              0.450,
              0.799,
              curve: Curves.bounceOut,
            ),
          ),
        ),
        containerCircleAnimation = new EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 50.0),
          end: const EdgeInsets.only(bottom: 0.0),
        ).animate(
          new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeanimation;
  final Animation buttomZoomOut;
  final int isLoginSuccess;
  final Widget redirectTo;
  //['default','faild','success']
  Future<Null> _playAnimation() async {
    try {
      await buttonController.forward();
      await buttonController.reverse();
    } on TickerCanceled {}
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return new Padding(
      padding: buttomZoomOut.value == 70
          ? const EdgeInsets.only(bottom: 50.0)
          : containerCircleAnimation.value,
      child: new InkWell(
          onTap: () {
            _playAnimation();
          },
          child: new Hero(
            tag: "fade",
            child: buttomZoomOut.value <= 300
                ? new Container(
                    width: buttomZoomOut.value == 70
                        ? buttonSqueezeanimation.value
                        : buttomZoomOut.value,
                    height:
                        buttomZoomOut.value == 70 ? 50.0 : buttomZoomOut.value,
                    alignment: FractionalOffset.center,
                    decoration: new BoxDecoration(
                      color: const Color.fromRGBO(247, 64, 106, 1.0),
                      borderRadius: buttomZoomOut.value < 400
                          ? new BorderRadius.all(const Radius.circular(20.0))
                          : new BorderRadius.all(const Radius.circular(0.0)),
                    ),
                    child: buttonSqueezeanimation.value > 75.0
                        ? new Text(
                            isLoginSuccess == 0
                                ? "Đăng nhập"
                                : isLoginSuccess == 1
                                    ? "Đăng nhập thất bại"
                                    : "Đăng nhập thành công",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          )
                        : buttomZoomOut.value < 300.0
                            ? new CircularProgressIndicator(
                                value: null,
                                strokeWidth: 2.0,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              )
                            : null)
                : new Container(
                    width: buttomZoomOut.value,
                    height: buttomZoomOut.value,
                    decoration: new BoxDecoration(
                      shape: buttomZoomOut.value < 500
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      color: const Color.fromRGBO(247, 64, 106, 1.0),
                    ),
                  ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    buttonController.addListener(() {
      if (buttonController.isCompleted) {
        // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) {
        //   return redirectTo;
        // }));
        if (redirectTo == null) {
          Get.offAllNamed('/pos');
        } else {
          Get.to(redirectTo);
        }
      }
    });
    return new AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}
