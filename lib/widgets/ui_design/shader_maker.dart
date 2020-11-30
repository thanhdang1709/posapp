import 'package:flutter/material.dart';

class ShaderMaskCustom extends StatelessWidget {
  const ShaderMaskCustom({
    Key key,
    this.icon,
  }) : super(key: key);

  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.topLeft,
          radius: 0.5,
          colors: <Color>[Colors.greenAccent[200], Colors.blueAccent[200]],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child: Icon(icon),
    );
  }
}
