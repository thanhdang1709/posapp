import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_app/screens/auth/components/animated_background.dart';
import 'package:pos_app/screens/auth/components/common_widget.dart';
import 'package:pos_app/screens/auth/register_page.dart';
import 'package:pos_app/widgets/snake_button.dart';
import 'package:pos_app/screens/auth/login_page.dart';

class WelcomePage extends StatelessWidget {
  final hideNotifier = ValueNotifier(false);
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_statements

    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimatedBackground(),
          ValueListenableBuilder(
            valueListenable: hideNotifier,
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn,
                top: 0,
                bottom: value ? -100 : 0,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  opacity: value ? 0.0 : 1.0,
                  child: child,
                ),
              );
            },
            child: Center(
              child: Container(
                height: size.height * .75,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Spacer(),
                      Center(
                        child: FindOutLogo(
                          fontSize: size.height * .065,
                        ),
                      ),
                      const SizedBox(height: 35),
                      const Spacer(flex: 5),
                      // Text(
                      //   'Hello',
                      //   style: GoogleFonts.poppins(
                      //     fontSize: size.height * .040,
                      //     fontWeight: FontWeight.w700,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      // Text(
                      //   'Everybody here',
                      //   style: GoogleFonts.poppins(
                      //       fontSize: size.height * .024, color: Colors.white),
                      // ),
                      // Image.asset("assets/img/logo.png"),
                      const Spacer(flex: 5),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SnakeButton(
                              onPressed: () => _openPage(context, LoginPage()),
                              child: Text(
                                'Đăng nhập',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: SnakeButton(
                              borderColor: Colors.orange,
                              onPressed: () =>
                                  _openPage(context, RegisterPage()),
                              child: Text(
                                'Đăng ký',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _openPage(BuildContext context, Widget page) async {
    hideNotifier.value = true;
    await Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(opacity: animation, child: page);
          },
        ));
    hideNotifier.value = false;
  }
}

class RectangularButton extends StatelessWidget {
  const RectangularButton({
    Key key,
    @required this.label,
    @required this.onPressed,
  }) : super(key: key);
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .070,
      child: FlatButton(
        onPressed: onPressed,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 3)),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
