import 'package:flutter/material.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/numpad/numpad_widget.dart';

class NumpadWidget extends StatelessWidget {
//Instantiate a NumpadController
  NumpadWidget(
      {this.productName, this.quantity, this.productId, this.callbackSubmit});

  final String productName;
  final int quantity;
  final int productId;
  final Function callbackSubmit;
  @override
  // ignore: override_on_non_overriding_member
  Widget build(BuildContext context) {
    final _controller = NumpadController(
        format: NumpadFormat.NONE, hintText: quantity.toString());
    //CartController cartController = Get.find();
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 50,
        centerTitle: false,
        title: productName,
      ),
      body: Container(
          child: Column(children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(26),
            child: NumpadText(
                controller: _controller, style: TextStyle(fontSize: 40))),
        Expanded(
            child: Numpad(
          controller: _controller,
          buttonTextSize: 40,
          submitInput: callbackSubmit,
        ))
      ])),
    );
  }
}
