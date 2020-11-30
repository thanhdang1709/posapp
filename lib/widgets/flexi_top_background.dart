import 'package:flutter/material.dart';

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
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(assetsImage),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.linearToSrgbGamma(),
            ),
          ),
        ),
        Container(
          // height: 350.0,
          decoration: BoxDecoration(
            color: titleColor,
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.7),
                Colors.cyan.withOpacity(0.7)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/sakura.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.linearToSrgbGamma(),
                alignment: Alignment.bottomRight),
          ),
        ),
      ],
    );
  }
}
