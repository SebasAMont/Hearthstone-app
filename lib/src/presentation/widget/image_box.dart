import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/util/constants_assets.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({
    required this.widgetImg,
    super.key,
  });

  final String? widgetImg;

  @override
  Widget build(BuildContext context) {
    return widgetImg != null
        ? CachedNetworkImage(
            imageUrl: widgetImg!,
            progressIndicatorBuilder: (
              context,
              url,
              downloadProgress,
            ) =>
                CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
            errorWidget: (
              context,
              url,
              error,
            ) =>
                Image.asset(
              assetCardBackImage,
            ),
          )
        : Image.asset(
            assetCardBackImage,
          );
  }
}
