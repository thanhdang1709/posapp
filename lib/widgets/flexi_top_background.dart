import 'package:flutter/material.dart';
import 'package:pos_app/config/palette.dart';

class FlexibleTopBackground extends StatelessWidget {
  const FlexibleTopBackground({
    Key key,
    this.assetsImage,
    this.titleColor = Colors.white,
  }) : super(key: key);
  final String assetsImage;
  final Color titleColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(assetsImage),
        //       fit: BoxFit.cover,
        //       colorFilter: ColorFilter.linearToSrgbGamma(),
        //     ),
        //   ),
        // ),
        Container(
          // height: 350.0,
          decoration: BoxDecoration(
            color: titleColor,
            gradient: LinearGradient(
              colors: [Palette.primaryColor.withOpacity(0.8), Palette.secondColor.withOpacity(0.9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/sakura.png'), fit: BoxFit.cover, colorFilter: ColorFilter.linearToSrgbGamma(), alignment: Alignment.bottomRight),
          ),
        ),
      ],
    );
  }
}
