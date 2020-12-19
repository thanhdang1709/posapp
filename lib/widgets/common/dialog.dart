import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

// ignore: slash_for_doc_comments
/** How to use
 
    DialogConfirm()
      .info(
        context: context,
        title: "Thông báo",
        desc: "Bạn có chắc chắn muốn xóa liên hệ này?",
      )
      .onCancel(
        text: "Đóng lại",
      )
      .onConfirm(
        text: "Đăng xuất",
        onPress: () {
          print('onConfirm');
        },
      )
      .show(hideIcon: false);
*/

class DialogConfirm {
  BuildContext context;
  String type;
  String title;
  String desc;
  Widget body;
  String cancelText;
  Function onPressCancel;
  IconData iconBtnCancel;
  Color colorBtnCancel;
  String confirmText;
  Function onPressConfirm;
  IconData iconBtnConfirm;
  Color colorBtnConfirm;

  Map dialogType = {
    'info': DialogType.INFO,
    'error': DialogType.ERROR,
    'success': DialogType.SUCCES,
    'warning': DialogType.WARNING,
  };

  error({context, title, desc, body}) {
    return this._show(
      type: "error",
      context: context,
      title: title,
      desc: desc,
      body: body,
    );
  }

  success({context, title, desc, body}) {
    return this._show(
      type: "success",
      context: context,
      title: title,
      desc: desc,
      body: body,
    );
  }

  warning({context, title, desc, body}) {
    return this._show(
      type: "warning",
      context: context,
      title: title,
      desc: desc,
      body: body,
    );
  }

  info({context, title, desc, body}) {
    return this._show(
      type: "info",
      context: context,
      title: title,
      desc: desc,
      body: body,
    );
  }

  _show({type, context, title, desc, body}) {
    this.context = context;
    this.type = type;
    this.title = title;
    this.desc = desc;
    this.body = body;

    return this;
  }

  onCancel({text, onPress, icon, color}) {
    this.cancelText = text;
    this.onPressCancel = onPress ?? () {};
    this.iconBtnCancel = icon;
    this.colorBtnCancel = color;

    return this;
  }

  onConfirm({text, onPress, icon, color}) {
    this.confirmText = text;
    this.onPressConfirm = onPress;
    this.iconBtnConfirm = icon;
    this.colorBtnConfirm = color;

    return this;
  }

  show({hideIcon = false, disableClickOutside = false}) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: hideIcon ? DialogType.NO_HEADER : dialogType[this.type],
      body: this.body,
      title: this.title ?? "",
      desc: this.desc ?? "",
      btnCancelText: this.cancelText,
      btnCancelOnPress: this.onPressCancel,
      btnCancelIcon: this.iconBtnCancel,
      btnCancelColor: this.colorBtnCancel,
      btnOkText: this.confirmText,
      btnOkOnPress: this.onPressConfirm,
      btnOkIcon: this.iconBtnConfirm,
      btnOkColor: this.colorBtnConfirm,
      dismissOnTouchOutside: !disableClickOutside,
      padding: EdgeInsets.all(0),
    )..show();
  }
}
