import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class OrderImage extends StatelessWidget {
  const OrderImage({
    required String image,
    super.key,
  }) : _image = image;

  final String _image;

  @override
  Widget build(BuildContext context) {
    return Material(
      surfaceTintColor: Constants.primaryColor,
      elevation: 2,
      shadowColor: Colors.transparent,
      borderRadius: Constants.mainBorderRadius / 2,
      child: SizedBox(
        width: 70,
        height: 70,
        child: ClipRRect(
          borderRadius: Constants.mainBorderRadius / 2,
          child: CachedNetworkImage(
            imageUrl: _image,
            fit: BoxFit.cover,
            errorWidget: (
              BuildContext context,
              String url,
              Object error,
            ) {
              return Center(
                child: Icon(Icons.error_rounded),
              );
            },
            progressIndicatorBuilder: (
              BuildContext context,
              String url,
              DownloadProgress progress,
            ) {
              return Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white12,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
