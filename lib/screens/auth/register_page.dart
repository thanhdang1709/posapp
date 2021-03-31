import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/data.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/screens/auth/components/clippers/inverted_top_border.dart';
import 'package:pos_app/screens/auth/components/common_widget.dart';
import 'package:pos_app/screens/auth/register_controller.dart';
import 'package:pos_app/widgets/button/button_submit.dart';
import 'package:pos_app/widgets/text_input.dart';

// ignore: must_be_immutable
class RegisterPage extends GetView {
// class RegisterPage extends StatefulWidget {
//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> with TickerProviderStateMixin {
  // AnimationController _registerButtonController;
  // var animationStatus = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _registerButtonController = new AnimationController(duration: new Duration(milliseconds: 1000), vsync: this);
  // }

  // @override
  // void dispose() {
  //   _registerButtonController.dispose();
  //   super.dispose();
  // }

  // ignore: unused_element
  // Future<Null> _playAnimation() async {
  //   try {
  //     await _registerButtonController.forward();
  //     await _registerButtonController.reverse();
  //   } on TickerCanceled {}
  // }

  bool first = true;
  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController());

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
                  bottom: value ? 0 : -Get.size.height * .4,
                  left: 0,
                  right: 0,
                  child: child,
                );
              },
              child: SizedBox(
                height: Get.size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: Get.size.height * .05),
                    Center(
                      child: FindOutLogo(
                        fontSize: Get.size.height * .07,
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        Center(child: _DragDownIndication()),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: ClipPath(
                            clipper: InvertedTopBorder(circularRadius: 40),
                            child: Container(
                              height: Get.size.height * .7,
                              width: double.infinity,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const SizedBox(height: 80),

                                    MyTextInput(
                                      controller: controller.nameController,
                                      hintText: 'account.full_name'.tr,
                                      iconData: FontAwesome.user,
                                      textInputType: TextInputType.name,
                                      hintColor: Colors.black,
                                      rules: {
                                        'required': 'auth.please_enter_full_name'.tr,
                                        'minLength': 6,
                                      },
                                      validateCallback: (e) {
                                        controller.isValidateName.value = e;
                                        controller.onValidate();
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    MyTextInput(
                                      controller: controller.phoneController,
                                      hintText: 'account.number_phone'.tr,
                                      iconData: FontAwesome.phone,
                                      textInputType: TextInputType.phone,
                                      hintColor: Colors.black,
                                      rules: {
                                        'required': 'auth.please_enter_number_phone'.tr,
                                        'phone': 'auth.wrong_number_phone'.tr,
                                        'minLength': 10,
                                      },
                                      validateCallback: (e) {
                                        controller.isValidatePhone.value = e;
                                        controller.onValidate();
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    MyTextInput(
                                      controller: controller.emailController,
                                      hintText: 'account.email'.tr,
                                      iconData: Icons.email,
                                      textInputType: TextInputType.emailAddress,
                                      hintColor: Colors.black,
                                      rules: {
                                        'required': 'auth.please_enter_email'.tr,
                                        'email': 'auth.wrong_email'.tr,
                                        'minLength': 6,
                                      },
                                      validateCallback: (e) {
                                        controller.isValidateEmail.value = e;
                                        controller.onValidate();
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    MyTextInput(
                                      controller: controller.shopNameController,
                                      hintText: 'label.store_name'.tr,
                                      iconData: Icons.business,
                                      textInputType: TextInputType.name,
                                      hintColor: Colors.black,
                                      rules: {
                                        'required': 'auth.please_enter_shop_name'.tr,
                                        'minLength': 6,
                                      },
                                      validateCallback: (e) {
                                        controller.isValidateShopName.value = e;
                                        controller.onValidate();
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    MyTextInput(
                                      controller: controller.addressController,
                                      hintText: 'common.address'.tr,
                                      iconData: FontAwesome.location_arrow,
                                      textInputType: TextInputType.text,
                                      hintColor: Colors.black,
                                      rules: {
                                        'required': 'auth.please_enter_address'.tr,
                                        'minLength': 6,
                                      },
                                      validateCallback: (e) {
                                        controller.isValidateAddress.value = e;
                                        controller.onValidate();
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Palette.secondColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 60,
                                      padding: EdgeInsets.only(left: 20),
                                      child: DropdownSearch<String>(
                                        dropdownSearchDecoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        mode: Mode.BOTTOM_SHEET,
                                        showSelectedItem: false,
                                        showSearchBox: true,
                                        isFilteredOnline: true,
                                        items: businessModel,
                                        hint: 'label.business_model'.tr,
                                        onChanged: (e) {},
                                        itemAsString: (String u) => u.toString(),
                                      ),
                                    ),
                                    //const SizedBox(height: 10),
                                    //BuildProvinceField(),
                                    const SizedBox(height: 10),
                                    MyTextInput(
                                      controller: controller.passwordController,
                                      hintText: 'auth.password'.tr,
                                      iconData: FontAwesome.lock,
                                      textInputType: TextInputType.visiblePassword,
                                      hintColor: Colors.black,
                                      rules: {
                                        'required': 'auth.please_enter_pwd'.tr,
                                        'minLength': 6,
                                      },
                                      validateCallback: (e) {
                                        controller.isValidatePassword.value = e;
                                        controller.onValidate();
                                      },
                                    ),
                                    // const SizedBox(height: 5),
                                    // // _AcceptTerms(),
                                    const SizedBox(height: 20),
                                    Obx(
                                      () => MyButtonSubmit(
                                        label: 'auth.sign_up'.tr,
                                        onPressed: controller.isDisableSubmit.value ? null : controller.handleSubmit,
                                        submiting: controller.isSubmitting.value,
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     print('hello');
                                    //   },
                                    //   child: StaggerAnimation(
                                    //     buttonController: _registerButtonController.view,
                                    //     onPress: () {
                                    //       if (first) {
                                    //         Map<String, dynamic> body = {
                                    //           'email': _emailController.text.trim(),
                                    //           'phone': _phoneController.text.trim(),
                                    //           'name': _nameController.text.trim(),
                                    //           'address': _addressController.text.trim(),
                                    //           'store_name': _shopNameController.text.trim(),
                                    //           'store_id': Uuid().v4(),
                                    //           'password': _passwordController.text.trim(),
                                    //         };
                                    //         // ignore: unnecessary_statements
                                    //         setState(() {
                                    //           first = false;
                                    //         });
                                    //         RegisterController().register(body);
                                    //       }
                                    //     },
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
          'auth.sign_up'.tr,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        Text(
          'common.slide_down_to_back'.tr,
          style: TextStyle(height: 2, fontSize: 12, color: Colors.white.withOpacity(.9)),
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
            "common.agree".tr,
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
