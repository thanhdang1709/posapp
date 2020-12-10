import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCircle extends StatelessWidget {
  const ImageCircle({Key key, this.image, this.height = 60, this.width = 60})
      : super(key: key);
  final String image;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: Colors.blue),
        // image:
        //     DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Transform.scale(
                  scale: 0.4,
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress)),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      //child: Image.asset('assets/avatar.jpg', fit: BoxFit.cover),
    );
  }
}
