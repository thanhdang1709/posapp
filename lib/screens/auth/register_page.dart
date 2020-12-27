import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pos_app/screens/auth/components/clippers/inverted_top_border.dart';
import 'package:pos_app/screens/auth/components/common_widget.dart';
import 'package:pos_app/screens/auth/components/text_input_find_out.dart';
import 'package:pos_app/screens/auth/register_controller.dart';
//import 'package:pos_app/widgets/provinces.dart';
import 'package:pos_app/widgets/stragger_animation.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  AnimationController _registerButtonController;
  var animationStatus = 0;

  @override
  void initState() {
    super.initState();
    _registerButtonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void dispose() {
    _registerButtonController.dispose();
    super.dispose();
  }

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  TextEditingController _phoneController = new TextEditingController();

  TextEditingController _shopNameController = new TextEditingController();
  //TextEditingController _nameController = new TextEditingController();

  // ignore: unused_element
  Future<Null> _playAnimation() async {
    try {
      await _registerButtonController.forward();
      await _registerButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        child: Stack(
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: resizeNotifier,
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  bottom: value ? 0 : -size.height * .5,
                  left: 0,
                  right: 0,
                  child: child,
                );
              },
              child: SizedBox(
                height: size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size.height * .05),
                    Center(
                      child: FindOutLogo(
                        fontSize: size.height * .065,
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        Center(child: _DragDownIndication()),
                        Padding(
                          padding: const EdgeInsets.only(top: 55),
                          child: ClipPath(
                            clipper: InvertedTopBorder(circularRadius: 40),
                            child: Container(
                              height: 490,
                              width: double.infinity,
                              color: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const SizedBox(height: 60),
                                    TextInputFindOut(
                                      controller: _nameController,
                                      label: 'Họ và tên',
                                      iconData: FontAwesome.user,
                                      textInputType: TextInputType.text,
                                    ),
                                    const SizedBox(height: 10),
                                    TextInputFindOut(
                                      controller: _phoneController,
                                      label: 'Số điện thoại',
                                      iconData: FontAwesome.phone,
                                      textInputType: TextInputType.text,
                                    ),
                                    const SizedBox(height: 10),
                                    TextInputFindOut(
                                      controller: _emailController,
                                      label: 'Email',
                                      iconData: Icons.alternate_email,
                                      textInputType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 10),
                                    TextInputFindOut(
                                      controller: _shopNameController,
                                      label: 'Tên cửa hàng',
                                      iconData: FontAwesome.map,
                                      textInputType: TextInputType.text,
                                    ),
                                    //const SizedBox(height: 10),
                                    //BuildProvinceField(),
                                    const SizedBox(height: 10),
                                    TextInputFindOut(
                                      controller: _passwordController,
                                      label: 'Mật khẩu',
                                      iconData: Icons.lock_outline,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                    ),
                                    const SizedBox(height: 5),
                                    _AcceptTerms(),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        print('hello');
                                      },
                                      child: StaggerAnimation(
                                        buttonController:
                                            _registerButtonController.view,
                                        onPress: () {
                                          Map<String, dynamic> body = {
                                            'email': _emailController.text,
                                            'phone': _phoneController.text,
                                            'name': _nameController.text,
                                            'store_name':
                                                _shopNameController.text,
                                            'store_id': Uuid().v4(),
                                            'password':
                                                _passwordController.text,
                                          };

                                          // ignore: unnecessary_statements
                                          RegisterController().register(body);
                                        },
                                      ),
                                    ),
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
          'Đăng ký',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        Text(
          'Vuốt để quay lại',
          style: TextStyle(
              height: 2, fontSize: 12, color: Colors.white.withOpacity(.9)),
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

class _AcceptTerms extends StatelessWidget {
  const _AcceptTerms({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final valueNotifier = ValueNotifier(false);
    return InkWell(
      onTap: () => valueNotifier.value = !valueNotifier.value,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (context, value, child) {
              return Checkbox(
                value: value,
                onChanged: (val) {},
                checkColor: Colors.white,
                activeColor: Colors.pinkAccent,
              );
            },
          ),
          Text(
            "Đồng ý",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          Text(
            " chính sách của chúng tôi",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.pinkAccent,
            ),
          ),
        ],
      ),
    );
  }
}
