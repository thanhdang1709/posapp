import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pos_app/screens/auth/components/clippers/inverted_top_border.dart';
import 'package:pos_app/screens/auth/components/common_widget.dart';
import 'package:pos_app/screens/auth/login_controller.dart';
import 'package:pos_app/widgets/button/button_submit.dart';
import 'package:pos_app/widgets/text_input.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginPage extends GetView<LoginController> {
  // AnimationController _loginButtonController;
  var animationStatus = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _loginButtonController = new AnimationController(duration: new Duration(milliseconds: 2000), vsync: this);
  // }

  // @override
  // void dispose() {
  //   _loginButtonController.dispose();
  //   super.dispose();
  // }

  // ignore: unused_element
  // Future<Null> _playAnimation() async {
  //   try {
  //     await _loginButtonController.forward();
  //     await _loginButtonController.reverse();
  //   } on TickerCanceled {}
  // }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    LoginController controller = Get.put(LoginController());
    final resizeNotifier = ValueNotifier(false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!resizeNotifier.value) resizeNotifier.value = true;
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta > 10) {
            resizeNotifier.value = false;
            Navigator.pop(context);
          }
        },
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: resizeNotifier,
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  bottom: value ? 0 : -Get.size.height,
                  left: 0,
                  right: 0,
                  child: child,
                );
              },
              child: SizedBox(
                height: Get.size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: Get.size.height * .2),
                    Center(
                      child: FindOutLogo(
                        fontSize: Get.size.height * .1,
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: _DragDownIndication(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: ClipPath(
                            clipper: InvertedTopBorder(circularRadius: 40),
                            child: Container(
                              height: Get.size.height * .45,
                              width: double.infinity,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const SizedBox(height: 60),
                                    // TextInputFindOut(
                                    //   controller: _emailController,
                                    //   label: 'Email',
                                    //   iconData: FontAwesome.user,
                                    //   textInputType: TextInputType.emailAddress,
                                    // ),
                                    MyTextInput(
                                      controller: controller.emailController,
                                      hintText: 'Email',
                                      iconData: FontAwesome.user,
                                      rules: {
                                        'required': 'Vui lòng điền email',
                                        'email': 'Địa chỉ email không đúng',
                                        'minLength': 6,
                                      },
                                      validateCallback: (e) {
                                        controller.isValidateEmail.value = e;
                                        controller.onValidate();
                                      },
                                    ),

                                    const SizedBox(height: 20),
                                    MyTextInput(
                                      controller: controller.passwordController,
                                      hintText: 'auth.password'.tr,
                                      iconData: FontAwesome.lock,
                                      textInputType: TextInputType.visiblePassword,
                                      rules: {
                                        'required': 'Vui lòng điền mật khẩu',
                                        'minLength': 6,
                                      },
                                      validateCallback: (e) {
                                        controller.isValidatePassword.value = e;
                                        controller.onValidate();
                                      },
                                    ),

                                    // Text(
                                    //   "Quên mật khẩu?",
                                    //   style: TextStyle(
                                    //     fontSize: 12,
                                    //     color: Colors.grey[600],
                                    //   ),
                                    // ),
                                    const SizedBox(height: 20),
                                    // animationStatus == 0
                                    //     ? new Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             bottom: 50.0),
                                    //         child: new InkWell(
                                    //             onTap: () {
                                    //               setState(() {
                                    //                 animationStatus = 1;
                                    //               });
                                    //               _playAnimation();
                                    //             },
                                    //             child: SizedBox(
                                    //               width: size.width * .65,
                                    //               child: FlatButton(
                                    //                 onPressed: () {
                                    //                   resizeNotifier.value =
                                    //                       false;
                                    //                   // return _openHomePage(
                                    //                   //     context);
                                    //                 },
                                    //                 padding:
                                    //                     const EdgeInsets.all(12),
                                    //                 shape: RoundedRectangleBorder(
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           10),
                                    //                 ),
                                    //                 color: Colors.pinkAccent,
                                    //                 child: Text(
                                    //                   "Đăng nhập",
                                    //                   style: TextStyle(
                                    //                     color: Colors.white,
                                    //                     fontSize: 16,
                                    //                     fontWeight:
                                    //                         FontWeight.w600,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             )),
                                    //       )
                                    //     : new
                                    Obx(
                                      () => MyButtonSubmit(
                                        label: 'auth.sign_in'.tr,
                                        radius: 10,
                                        onPressed: controller.isDisableSubmit.value ? null : controller.handleSubmitLogin,
                                        submiting: controller.isSubmiting.value,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // GestureDetector(
                                    //   onTap: () {},
                                    //   child: SizedBox(
                                    //     child: StaggerAnimation(
                                    //       buttonController: _loginButtonController.view,
                                    //       onPress: () {
                                    //         Map<String, String> body = {'email': controller.emailController.text, 'password': _passwordController.text, 'device_name': 'test'};
                                    //         if (_emailController.text.isEmpty || _passwordController.text.isEmpty)
                                    //           AppUltils().getSnackBarError(message: 'Vui lòng điền đầy đủ thông tin');
                                    //         else
                                    //           LoginController().login(body);
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  _openHomePage(BuildContext context) {
    final newRoute = PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: Container(
            child: Text("home"),
          ),
        );
      },
    );
    Navigator.pushAndRemoveUntil(context, newRoute, ModalRoute.withName(''));
  }
}

class _DragDownIndication extends StatelessWidget {
  const _DragDownIndication({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Đăng nhập',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        Text(
          'Vuốt để quay lại',
          style: TextStyle(height: 2, fontSize: 14, color: Colors.white.withOpacity(.7)),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white.withOpacity(.8),
          size: 35,
        ),
      ],
    );
  }
}
