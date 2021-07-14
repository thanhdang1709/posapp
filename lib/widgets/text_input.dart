import 'package:flutter/material.dart';
import 'package:pos_app/ultils/validation.dart';
import 'package:pos_app/config/palette.dart';

class MyTextInput extends StatefulWidget {
  const MyTextInput(
      {Key key,
      @required this.hintText,
      @required this.iconData,
      this.textInputType,
      this.controller,
      this.label = '',
      this.rules,
      this.validateCallback,
      //this.isEnable = true,
      this.background,
      this.hintColor,
      this.maxLines = 1,
      this.filled = false})
      : super(key: key);
  final String hintText;
  final IconData iconData;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String label;
  final Map<String, dynamic> rules;
  final Function validateCallback;
  final Color background;
  final Color hintColor;
  final int maxLines;
  final bool filled;
  //final bool isEnable;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<MyTextInput> {
  var label;
  @override
  Widget build(BuildContext context) {
    final isPassword = widget.textInputType == TextInputType.visiblePassword;
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey[100], width: 2, style: BorderStyle.solid),
    );

    final hidePasswordNotifier = ValueNotifier(true);
    return ValueListenableBuilder(
      valueListenable: hidePasswordNotifier,
      builder: (context, value, child) {
        return TextFormField(
          controller: widget.controller,
          keyboardType: widget.textInputType,
          obscureText: isPassword ? value : false,
          style: TextStyle(color: Colors.black),
          maxLines: widget.maxLines,
          onChanged: (e) {
            setState(() {
              label = (validate(controller: widget.controller, rules: widget.rules));
              if (label == '') {
                widget.validateCallback(true);
              } else {
                widget.validateCallback(false);
              }
            });
          },
          decoration: InputDecoration(
            filled: widget.filled,
            fillColor: widget.background ?? Palette.secondColor.withOpacity(0.2),
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () => hidePasswordNotifier.value = !hidePasswordNotifier.value,
                    icon: Icon(
                      value ? Icons.visibility : Icons.visibility_off,
                      color: Palette.primaryColor,
                    ),
                  )
                : null,
            enabledBorder: outlineInputBorder,
            helperStyle: TextStyle(color: Colors.grey),
            hintText: widget.hintText,
            labelText: label == '' ? null : label,
            labelStyle: label == '' ? null : TextStyle(color: Colors.red),
            focusedBorder: outlineInputBorder.copyWith(
                borderSide: BorderSide(
                    color: label == null
                        ? Palette.primaryColor
                        : label == ''
                            ? Palette.secondColor
                            : Colors.red,
                    width: 2)),
            hintStyle: TextStyle(color: widget.hintColor ?? Palette.primaryColor),
            prefixIcon: widget.iconData != null
                ? Icon(widget.iconData,
                    color: label == null
                        ? Palette.secondColor
                        : label == ''
                            ? Palette.secondColor
                            : Colors.red,
                    size: 18)
                : null,
          ),
        );
      },
    );
  }
}

// rules = {
//   'required':'Vui lòng nhập mật khẩu',
//   'minLength':6,
// }
String validate({
  String errorMessage = '',
  Map<String, dynamic> rules,
  TextEditingController controller,
}) {
  String errorMessage = '';
  try {
    if (rules.containsKey('required') && controller.text == '') {
      rules.forEach(
        (k, v) {
          if (k == 'required') {
            errorMessage = v;
          } else {
            errorMessage = '';
          }
        },
      );
    }
    if (rules.containsKey('minLength') && errorMessage == '') {
      rules.forEach(
        (k, v) {
          if (k == 'minLength') {
            if (controller.text.length < v) {
              errorMessage = 'Tối thiểu $v ký tự';
            } else {
              errorMessage = '';
            }
          }
        },
      );
    }
    if (rules.containsKey('email') && errorMessage == '') {
      rules.forEach(
        (k, v) {
          if (!Validator.isEmail(controller.text)) {
            errorMessage = 'Email không hợp lệ';
          } else {
            errorMessage = '';
          }
        },
      );
    }
    if (rules.containsKey('phone') && errorMessage == '') {
      rules.forEach(
        (k, v) {
          if (!Validator.isPhoneNumber(controller.text)) {
            errorMessage = 'Số điện thoại không hợp lệ';
          } else {
            errorMessage = '';
          }
        },
      );
    }
    if (rules.containsKey('emailAndPassword') && errorMessage == '') {
      rules.forEach(
        (k, v) {
          if (!Validator.isEmail(controller.text)) {
            errorMessage = 'Email hoặc Sđt không hợp lệ';
            if (!Validator.isPhoneNumber(controller.text)) {
              errorMessage = 'Email hoặc Sđt không hợp lệ';
            } else {
              errorMessage = '';
            }
          } else {
            errorMessage = '';
          }
        },
      );
    }
    // else {
    //   errorMessage = '';
    // }
  } catch (e) {}
  return errorMessage;
}
