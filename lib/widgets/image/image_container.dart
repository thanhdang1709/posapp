import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerImageProduct extends StatelessWidget {
  const ContainerImageProduct({Key key, this.imageUrl}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * .25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          // progressIndicatorBuilder: (context, url, downloadProgress) =>
          //     Transform.scale(
          //   scale: 0.3,
          //   child: CircularProgressIndicator(value: downloadProgress.progress),
          // ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
